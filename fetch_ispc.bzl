"""ispc library fetch"""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

def fetch_ispc():
    """function which fetch remote prebuild ISPC
    """

    http_archive(
        name = "ispc_linux_x86_64",
        urls = [
            "https://github.com/ispc/ispc/releases/download/v1.19.0/ispc-v1.19.0-linux.tar.gz",
        ],
        #sha256 = "7faf59f26c09ceffe6165805d9e40b6582ddc1417c12786a214f4536e3388b47",
        strip_prefix = "ispc-v1.19.0-linux",
        build_file = "@rules_ispc//:ispc_linux_x86_64.BUILD",
    )

    http_archive(
        name = "ispc_windows_x86_64",
        urls = [
            "https://github.com/ispc/ispc/releases/download/v1.19.0/ispc-v1.19.0-windows.zip"
        ],
        sha256 = "f99a0afd4c8b5e8aceb46af8e90a7ba0813bf4c4111044ced27d498591304f9c",
        strip_prefix = "ispc-v1.19.0-windows",
        build_file = "@rules_ispc//:ispc_windows_x86_64.BUILD",
    )

    http_archive(
        name = "ispc_osx_x86_64",
        urls = [
            "https://github.com/ispc/ispc/releases/download/v1.18.0/ispc-v1.18.0-macOS.tar.gz",
        ],
        sha256 = "d1435b541182406ff6b18446d31ecceef0eae3aed7654391ae676d3142e0000d",
        strip_prefix = "ispc-v1.18.0-macOS",
        build_file = "@rules_ispc//:ispc_osx_x86_64.BUILD",
    )
