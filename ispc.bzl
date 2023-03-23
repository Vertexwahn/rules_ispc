"""A rule that compiles ISPC programs and make them available as a C++ library.
"""

def _ispc_cc_library_impl(ctx):
    info = ctx.toolchains["@rules_ispc//tools:toolchain_type"].ispc_info
    default_target_os = info.default_target_os

    generated_header_filename = ctx.attr.generated_header_filename

    ispc_defines_list = ""
    if len(ctx.attr.defines) > 0:
        ispc_defines_list = "-D" + " -D".join(ctx.attr.defines)

    srcs = ctx.files.srcs
    inputs = depset(srcs)  # see https://bazel.build/extending/rules

    output_file1 = ctx.actions.declare_file(generated_header_filename)
    output_file2 = ctx.actions.declare_file(ctx.attr.name + ".o")

    args = ctx.actions.args()
    args.add("-o", generated_header_filename)
    args.add(ispc_defines_list)
    args.add("--target=neon")
    args.add("--target-os=%s" % default_target_os)
    args.add("--arch=aarch64")
    args.add("--addressing=64")
    args.add("--pic")
    args.add("square.ispc")#ctx.attr.ispc_main_source_file)
    args.add("--header-outfile=%s" % generated_header_filename)
    args.add("-o")
    args.add(ctx.attr.name + ".o")

    ctx.actions.run(
        inputs = inputs,
        outputs = [output_file1, output_file2],
        arguments = [args],
        executable = info.ispc_path,
    )

    return [
        #DefaultInfo()
        #DefaultInfo(files = depset([output_file1, output_file2])),
        OutputGroupInfo(out = depset([output_file1, output_file2]))
    ]

ispc_library2 = rule(
    implementation = _ispc_cc_library_impl,
    doc = """Compiles a ISPC program and makes it available as a C++ library

This rule uses a precompiled version of ISPC v1.19.0 for compilation.""",
    attrs = {
        "generated_header_filename": attr.string(
            doc = """
            Name of the generated header file.
            """,
        ),
        "ispc_main_source_file": attr.label(
            allow_single_file = [".ispc"],
            doc = """
            File to compile.
            """,
        ),
        "srcs": attr.label_list(
            allow_files = [".ispc", ".isph"],
            doc = """
            The list of ISPC source files that are compiled to create the library.
            Only `.ispc` and `.isph` files are permitted.
            """,
        ),
        "defines": attr.string_list(
            doc = """
            List of defines handed over to the ISPC compiler.
            """,
        ),
        #"out": attr.output_list(),
    },
    #outputs = {
    #    "out": "{generated_header_filename}.o"
    #},
    toolchains = ["@rules_ispc//tools:toolchain_type"],
)

def ispc_cc_library2(name, generated_header_filename, ispc_main_source_file, srcs, defines = [], **kwargs):
    ispc_library2(
        name = "%s_ispc_gen" % name,
        generated_header_filename = generated_header_filename,
        ispc_main_source_file = ispc_main_source_file,
        srcs = srcs,
        defines = defines,
        **kwargs
    )
    native.cc_library(
        name = name,
        srcs = [name + ".o"],
        hdrs = [name + ".h"],
        defines = defines,
        #deps = ["%s_ispc_gen" % name],
        **kwargs
    )

def ispc_cc_library(name, out, ispc_main_source_file, srcs, defines = [], **kwargs):
    generated_header_filename = out

    ispc_defines_list = ""
    if len(defines) > 0:
        ispc_defines_list = "-D" + " -D".join(defines)

    native.genrule(
        name = "%s_ispc_gen" % name,
        srcs = srcs,
        outs = [name + ".o", generated_header_filename],
        cmd = select({
            "@platforms//os:linux": "$(location @ispc_linux_x86_64//:ispc) %s --target=avx2 --target-os=linux --arch=x86-64 --addressing=64 --pic $(locations %s) --header-outfile=$(location %s) -o $(location %s.o)" % (ispc_defines_list, ispc_main_source_file, generated_header_filename, name),
            "@rules_ispc//:osx_arm64": "$(location @ispc_osx_arm64//:ispc) %s --target=neon --target-os=macos --arch=aarch64 --addressing=64 --pic $(locations %s) --header-outfile=$(location %s) -o $(location %s.o)" % (ispc_defines_list, ispc_main_source_file, generated_header_filename, name),
            "@rules_ispc//:osx_x86_64": "$(location @ispc_osx_x86_64//:ispc) %s --target=sse2 --target-os=macos --arch=x86-64 --addressing=64 --pic $(locations %s) --header-outfile=$(location %s) -o $(location %s.o)" % (ispc_defines_list, ispc_main_source_file, generated_header_filename, name),
            "@platforms//os:windows": "$(location @ispc_windows_x86_64//:ispc) %s --target=avx2 --target-os=windows --arch=x86-64 --addressing=64 $(locations %s) --header-outfile=$(location %s) -o $(location %s.o)" % (ispc_defines_list, ispc_main_source_file, generated_header_filename, name),
        }),
        tools = select({
            "@platforms//os:linux": ["@ispc_linux_x86_64//:ispc"],
            "@rules_ispc//:osx_arm64": ["@ispc_osx_arm64//:ispc"],
            "@rules_ispc//:osx_x86_64": ["@ispc_osx_x86_64//:ispc"],
            "@platforms//os:windows": ["@ispc_windows_x86_64//:ispc"],
        }),
    )
    native.cc_library(
        name = name,
        srcs = [name + ".o"],
        hdrs = [name + ".h"],
        defines = defines,
        **kwargs
    )
