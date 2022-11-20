def ispc_cc_library(name, srcs,  target_compatible_with = [], **kwargs):
    for ispc_source_file in srcs:
        generted_header_filename = name + ".h"
        native.genrule(
            name = "%s_ispc_gen" % name,
            srcs = [ispc_source_file],
            outs = [name + ".o", generted_header_filename],
            cmd = select({
                "@platforms//os:linux": "$(location @ispc_linux_x86_64//:ispc) --target=avx2 --arch=x86-64 $(locations %s) --header-outfile=%s -o %s.o" % (ispc_source_file, generted_header_filename, name),
                "@platforms//os:windows": "$(location @ispc_windows_x86_64//:ispc) --target=avx2 --target-os=windows --arch=x86-64 $(locations %s) --header-outfile=%s -o %s.o" % (ispc_source_file, generted_header_filename, name),
            }),
            tools = select({
                "@platforms//os:linux": ["@ispc_linux_x86_64//:ispc"],
                "@platforms//os:windows": ["@ispc_windows_x86_64//:ispc"],
            }),
            target_compatible_with = target_compatible_with,
        )
        native.cc_library(
            name = name,
            srcs = [name + ".o"],
            hdrs = [name + ".h"],
            target_compatible_with = target_compatible_with,
            **kwargs
        )
