"""Toolchain for ISPC compiler.
"""

IspcToolchainInfo = provider(
    doc = "Information about how to invoke ISPC compiler.",
    fields = [
        "ispc_path",
        "target_os",
    ],
)

def _ispc_toolchain_impl(ctx):
    expand_ispc_path = ctx.expand_location(ctx.attr.ispc_cmd, ctx.attr.data)
    toolchain_info = platform_common.ToolchainInfo(
        ispc_info = IspcToolchainInfo(
            ispc_path = expand_ispc_path,
            target_os = ctx.attr.target_os,
        ),
    )
    return [toolchain_info]

ispc_toolchain = rule(
    implementation = _ispc_toolchain_impl,
    attrs = {
        "ispc_cmd": attr.string(),
        "target_os": attr.string(),
        "data": attr.label_list(allow_files = True),
    },
)

def register_ispc_toolchains():
    native.register_toolchains(
        "@rules_ispc//tools:ispc_linux_toolchain",
        "@rules_ispc//tools:ispc_windows_toolchain",
        "@rules_ispc//tools:ispc_osx_toolchain",
        "@rules_ispc//tools:ispc_osx_arm64_toolchain",
    )
