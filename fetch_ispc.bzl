"""ISPC compiler fetch"""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

def fetch_ispc():
    """function which fetches the remote prebuild ISPC compiler
    """

    # See for download links https://ispc.github.io/downloads.html

    http_archive(
        name = "ispc_linux_x86_64",
        urls = [
            "https://github.com/ispc/ispc/releases/download/v1.22.0/ispc-v1.22.0-linux.tar.gz",
        ],
        sha256 = "8c935ef7537c241a519f2632e6ffeae0988a64f21db78d403ceaa4c52517b416",
        strip_prefix = "ispc-v1.22.0-linux",
        build_file = "@rules_ispc//:ispc_linux_x86_64.BUILD",
    )

    http_archive(
        name = "ispc_windows_x86_64",
        urls = [
            "https://github.com/ispc/ispc/releases/download/v1.22.0/ispc-v1.22.0-windows.zip",
        ],
        sha256 = "e597a1568675d5c5ad9cf2fe5be2653d279c74b46d0e899a01a844770a0a9ad1",
        strip_prefix = "ispc-v1.22.0-windows",
        build_file = "@rules_ispc//:ispc_windows_x86_64.BUILD",
    )

    http_archive(
        name = "ispc_osx_x86_64",
        urls = [
            "https://github.com/ispc/ispc/releases/download/v1.22.0/ispc-v1.22.0-macOS.x86_64.tar.gz",
        ],
        sha256 = "e700725416e41c021fb3f603363aeb52f9f3fbb3d91d3ddaf9b6efe3d249ce90",
        strip_prefix = "ispc-v1.22.0-macOS.x86_64",
        build_file = "@rules_ispc//:ispc_osx_x86_64.BUILD",
    )

    http_archive(
        name = "ispc_osx_arm64",
        urls = [
            "https://github.com/ispc/ispc/releases/download/v1.22.0/ispc-v1.22.0-macOS.arm64.tar.gz",
        ],
        sha256 = "3520c4f3b1c9ecf09059c04842469852a333ea30dfca37aaa0d169efc6d2e58c",
        strip_prefix = "ispc-v1.22.0-macOS.arm64",
        build_file = "@rules_ispc//:ispc_osx_arm64.BUILD",
    )
