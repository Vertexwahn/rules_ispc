"""ispc library fetch"""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

def fetch_ispc():
    """function which fetch remote prebuild ISPC
    """

    http_archive(
        name = "ispc_linux_x86_64",
        urls = [
            "https://github.com/ispc/ispc/releases/download/v1.18.1/ispc-v1.18.1-linux.tar.gz",
        ],
        #sha256 = "",
        strip_prefix = "ispc-v1.18.1-linux",
        build_file = "@rules_ispc//:ispc_linux_x86_64.BUILD",
    )

    http_archive(
        name = "ispc_windows_x86_64",
        urls = [
            "https://ci.appveyor.com/api/projects/ispc/ispc/artifacts/build%2Fispc-trunk-windows.zip?job=Environment%3A%20APPVEYOR_BUILD_WORKER_IMAGE%3DVisual%20Studio%202019%2C%20LLVM_VERSION%3Dlatest",
        ],
        sha256 = "99b28eac89fb21980f56d76f74e46b78c89c7523b052d86fd2384fb293272a08",
        strip_prefix = "ispc-trunk-windows",
        build_file = "@rules_ispc//:ispc_windows_x86_64.BUILD",
    )
