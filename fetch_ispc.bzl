"""ISPC compiler fetch"""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

def fetch_ispc():
    """function which fetches the remote prebuild ISPC compiler
    """

    # For download link see https://ispc.github.io/downloads.html

    http_archive(
        name = "ispc_linux_x86_64",
        urls = [
            "https://github.com/ispc/ispc/releases/download/v1.20.0/ispc-v1.20.0-linux.tar.gz",
        ],
        #sha256 = "f99a0afd4c8b5e8aceb46af8e90a7ba0813bf4c4111044ced27d498591304f9c",
        strip_prefix = "ispc-v1.20.0-linux",
        build_file = "@rules_ispc//:ispc_linux_x86_64.BUILD",
    )

    http_archive(
        name = "ispc_windows_x86_64",
        urls = [
            "https://github.com/ispc/ispc/releases/download/v1.20.0/ispc-v1.20.0-windows.zip",
        ],
        #sha256 = "3f2953f9328290adfd0143707dce13e342f6df1099b3be5148a25e41347f958c",
        strip_prefix = "ispc-v1.20.0-windows",
        build_file = "@rules_ispc//:ispc_windows_x86_64.BUILD",
    )

    http_archive(
        name = "ispc_osx_x86_64",
        urls = [
            "https://github.com/ispc/ispc/releases/download/v1.20.0/ispc-v1.20.0-macOS.x86_64.tar.gz",
        ],
        #sha256 = "ff203980215c1385849d1580cbf82aa5edbf17b23d0667d593301d1c9f7f0e1e",
        strip_prefix = "ispc-v1.20.0-macOS.x86_64",
        build_file = "@rules_ispc//:ispc_osx_x86_64.BUILD",
    )

    http_archive(
        name = "ispc_osx_arm64",
        urls = [
            "https://github.com/ispc/ispc/releases/download/v1.20.0/ispc-v1.20.0-macOS.arm64.tar.gz",
        ],
        sha256 = "c423a5a88d7a9a6ed667e41d025801c123fa0c5fd384d4ea138fa1fcf2bc24c9",
        strip_prefix = "ispc-v1.20.0-macOS.arm64",
        build_file = "@rules_ispc//:ispc_osx_arm64.BUILD",
    )
