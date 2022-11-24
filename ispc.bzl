def ispc_cc_library(name, srcs, target_compatible_with = [], **kwargs):
    generted_header_filename = name + ".h"
    ispc_source_file = name + ".ispc"  # main file
    native.genrule(
        name = "%s_ispc_gen" % name,
        srcs = srcs,
        outs = [name + ".o", generted_header_filename],
        cmd = select({
            "@platforms//os:linux": "$(location @ispc_linux_x86_64//:ispc) --target=avx2 --arch=x86-64 $(locations %s) --header-outfile=$(location %s) -o $(location %s.o)" % (ispc_source_file, generted_header_filename, name),
            "@platforms//os:osx": "$(location @ispc_osx_x86_64//:ispc) --target=avx2 --arch=x86-64 $(locations %s) --header-outfile=$(location %s) -o $(location %s.o)" % (ispc_source_file, generted_header_filename, name),
            "@platforms//os:windows": "$(location @ispc_windows_x86_64//:ispc) --target=avx2 --target-os=windows --arch=x86-64 $(locations %s) --header-outfile=$(location %s) -o $(location %s.o)" % (ispc_source_file, generted_header_filename, name),
        }),
        tools = select({
            "@platforms//os:linux": ["@ispc_linux_x86_64//:ispc"],
            "@platforms//os:osx": ["@ispc_osx_x86_64//:ispc"],
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
