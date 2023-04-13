"""A rule that compiles ISPC programs and make them available as a C++ library.
"""

def _ispc_cc_library_impl(ctx):
    info = ctx.toolchains["@rules_ispc//tools:toolchain_type"].ispc_info
    default_target = info.default_target
    default_target_os = info.default_target_os
    default_arch = info.default_arch
    ispc_path = info.ispc_path

    ispc_defines_list = ""
    if len(ctx.attr.defines) > 0:
        ispc_defines_list = "-D" + " -D".join(ctx.attr.defines)

    srcs = ctx.files.srcs
    inputs = depset(srcs)

    object = ctx.actions.declare_file(ctx.attr.name + ".o")

    args = ctx.actions.args()

    if len(ctx.attr.defines) > 0:
        args.add(ispc_defines_list)

    args.add("--target=%s" % default_target)
    args.add("--target-os=%s" % default_target_os)
    args.add("--arch=%s" % default_arch)
    args.add("--addressing=64")

    if default_target_os != "windows":
        args.add("--pic")

    args.add(ctx.file.ispc_main_source_file)
    args.add("--header-outfile=%s" % ctx.outputs.out.path)
    args.add("-o", object)

    exec_requirements = {}
    for elem in ctx.attr.tags:
        exec_requirements[elem] = "1"

    ctx.actions.run(
        inputs = inputs,
        outputs = [object, ctx.outputs.out],
        arguments = [args],
        executable = ispc_path,
        execution_requirements = exec_requirements,
    )

    return [
        DefaultInfo(files = depset(direct = [object])),
    ]

ispc_library = rule(
    implementation = _ispc_cc_library_impl,
    doc = """Compiles a ISPC program and makes it available as a C++ library

This rule uses a precompiled version of ISPC v1.19.0 for compilation.""",
    attrs = {
        "out": attr.output(
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
    },
    toolchains = ["@rules_ispc//tools:toolchain_type"],
)

def ispc_cc_library(name, out, ispc_main_source_file, srcs, defines = [], **kwargs):
    ispc_library(
        name = "%s_ispc_gen" % name,
        out = out,
        ispc_main_source_file = ispc_main_source_file,
        srcs = srcs,
        defines = defines,
        tags = ["local"],
        **kwargs
    )
    native.cc_library(
        name = name,
        srcs = [":%s_ispc_gen" % name],
        hdrs = [name + ".h"],
        defines = defines,
        **kwargs
    )
