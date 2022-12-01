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
        sha256 = "7faf59f26c09ceffe6165805d9e40b6582ddc1417c12786a214f4536e3388b47",
        strip_prefix = "ispc-v1.18.1-linux",
        build_file = "@rules_ispc//:ispc_linux_x86_64.BUILD",
    )

    http_archive(
        name = "ispc_windows_x86_64",
        urls = [
            # Hash code seem to change often - did not find out how to get a specific version/how to pin it
            #"https://ci.appveyor.com/api/projects/ispc/ispc/artifacts/build%2Fispc-trunk-windows.zip?job=Environment%3A%20APPVEYOR_BUILD_WORKER_IMAGE%3DVisual%20Studio%202019%2C%20LLVM_VERSION%3Dlatest",
            "https://mirror.vertexwahn.de/ci.appveyor.com/api/projects/ispc/ispc/artifacts/build/ispc-trunk-windows.zip",
        ],
        sha256 = "5cba78af81a754edb42a1a1b3e8e4b6eb6f69c588690444e5afa0bcaa78939d0",
        strip_prefix = "ispc-trunk-windows",
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
