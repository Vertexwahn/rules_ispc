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
        sha256 = "e6412b88aa312fcd10c46f92df0149ccc4d99e53552c4ce127aa6c634fe9b308",
        strip_prefix = "ispc-v1.22.0-linux",
        build_file = "@rules_ispc//:ispc_linux_x86_64.BUILD",
    )

    http_archive(
        name = "ispc_windows_x86_64",
        urls = [
            "https://github.com/ispc/ispc/releases/download/v1.22.0/ispc-v1.22.0-windows.zip",
        ],
        sha256 = "e212ebfb4e8afb57adc103a2579c52673a3ca49610fbc2a5eae643d3d378548d",
        strip_prefix = "ispc-v1.22.0-windows",
        build_file = "@rules_ispc//:ispc_windows_x86_64.BUILD",
    )

    http_archive(
        name = "ispc_osx_x86_64",
        urls = [
            "https://github.com/ispc/ispc/releases/download/v1.22.0/ispc-v1.22.0-macOS.x86_64.tar.gz",
        ],
        sha256 = "e25222d2d6f4f8e3561556ac73f88721ceb5486439d6c2a566d37407ad9a5907",
        strip_prefix = "ispc-v1.22.0-macOS.x86_64",
        build_file = "@rules_ispc//:ispc_osx_x86_64.BUILD",
    )

    http_archive(
        name = "ispc_osx_arm64",
        urls = [
            "https://github.com/ispc/ispc/releases/download/v1.22.0/ispc-v1.22.0-macOS.arm64.tar.gz",
        ],
        sha256 = "c423a5a88d7a9a6ed667e41d025801c123fa0c5fd384d4ea138fa1fcf2bc24c9",
        strip_prefix = "ispc-v1.22.0-macOS.arm64",
        build_file = "@rules_ispc//:ispc_osx_arm64.BUILD",
    )
