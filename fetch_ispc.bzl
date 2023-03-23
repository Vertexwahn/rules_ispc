"""ISPC compiler fetch"""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

def fetch_ispc():
    """function which fetches the remote prebuild ISPC compiler
    """

    # For download link see https://ispc.github.io/downloads.html
    
    http_archive(
        name = "ispc_linux_x86_64",
        urls = [
            "https://github.com/ispc/ispc/releases/download/v1.19.0/ispc-v1.19.0-linux.tar.gz",
        ],
        sha256 = "f99a0afd4c8b5e8aceb46af8e90a7ba0813bf4c4111044ced27d498591304f9c",
        strip_prefix = "ispc-v1.19.0-linux",
        build_file = "@rules_ispc//:ispc_linux_x86_64.BUILD",
    )

    http_archive(
        name = "ispc_windows_x86_64",
        urls = [
            "https://github.com/ispc/ispc/releases/download/v1.19.0/ispc-v1.19.0-windows.zip"
        ],
        sha256 = "3f2953f9328290adfd0143707dce13e342f6df1099b3be5148a25e41347f958c",
        strip_prefix = "ispc-v1.19.0-windows",
        build_file = "@rules_ispc//:ispc_windows_x86_64.BUILD",
    )

    http_archive(
        name = "ispc_osx_x86_64",
        urls = [
            "https://github.com/ispc/ispc/releases/download/v1.19.0/ispc-v1.19.0-macOS.tar.gz",
        ],
        sha256 = "f61993807ba00d5deeb46f65be7e38d7c95bcfb6e6e114993afa53b44320556c",
        strip_prefix = "ispc-v1.19.0-macOS",
        build_file = "@rules_ispc//:ispc_osx_x86_64.BUILD",
    )

    http_archive(
        name = "ispc_osx_arm64",
        urls = [
            "https://github.com/ispc/ispc/releases/download/v1.19.0/ispc-v1.19.0-macOS.arm.tar.gz",
        ],
        sha256 = "47b9fba87affde0842752dc6485bd544c13030872cac1190fb4354fe30580b8c",
        strip_prefix = "ispc-v1.19.0-macOS.arm",
        build_file = "@rules_ispc//:ispc_osx_arm64.BUILD",
    )
