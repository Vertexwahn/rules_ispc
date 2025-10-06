"""ISPC compiler fetch"""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

# Version metadata for supported ISPC versions
_ISPC_VERSIONS = {
    "1.22.0": {
        "linux": {
            "url": "https://github.com/ispc/ispc/releases/download/v1.22.0/ispc-v1.22.0-linux.tar.gz",
            "sha256": "8c935ef7537c241a519f2632e6ffeae0988a64f21db78d403ceaa4c52517b416",
            "strip_prefix": "ispc-v1.22.0-linux",
        },
        "windows": {
            "url": "https://github.com/ispc/ispc/releases/download/v1.22.0/ispc-v1.22.0-windows.zip",
            "sha256": "e597a1568675d5c5ad9cf2fe5be2653d279c74b46d0e899a01a844770a0a9ad1",
            "strip_prefix": "ispc-v1.22.0-windows",
        },
        "osx_x86_64": {
            "url": "https://github.com/ispc/ispc/releases/download/v1.22.0/ispc-v1.22.0-macOS.x86_64.tar.gz",
            "sha256": "e700725416e41c021fb3f603363aeb52f9f3fbb3d91d3ddaf9b6efe3d249ce90",
            "strip_prefix": "ispc-v1.22.0-macOS.x86_64",
        },
        "osx_arm64": {
            "url": "https://github.com/ispc/ispc/releases/download/v1.22.0/ispc-v1.22.0-macOS.arm64.tar.gz",
            "sha256": "3520c4f3b1c9ecf09059c04842469852a333ea30dfca37aaa0d169efc6d2e58c",
            "strip_prefix": "ispc-v1.22.0-macOS.arm64",
        },
    },
    "1.23.0": {
        "linux": {
            "url": "https://github.com/ispc/ispc/releases/download/v1.23.0/ispc-v1.23.0-linux.tar.gz",
            "sha256": "fc31f53f77a67cb5b465727b70af7d6cde8f38012c4ca0f1678b174a955cb5a8",
            "strip_prefix": "ispc-v1.23.0-linux",
        },
        "windows": {
            "url": "https://github.com/ispc/ispc/releases/download/v1.23.0/ispc-v1.23.0-windows.zip",
            "sha256": "709350902381968ee58fd67e9aed63df99b1313bc55a94195977bcc8d90bdced",
            "strip_prefix": "ispc-v1.23.0-windows",
        },
        "osx_x86_64": {
            "url": "https://github.com/ispc/ispc/releases/download/v1.23.0/ispc-v1.23.0-macOS.x86_64.tar.gz",
            "sha256": "b9e6dcc045f5a2e29a6c43354b6a747c4486a341608d785f5f99eca8ac207a72",
            "strip_prefix": "ispc-v1.23.0-macOS.x86_64",
        },
        "osx_arm64": {
            "url": "https://github.com/ispc/ispc/releases/download/v1.23.0/ispc-v1.23.0-macOS.arm64.tar.gz",
            "sha256": "2cf144aaa6d8117e3a9e0782984fa4cb45127387dd4fb385b187115d6c1a0d68",
            "strip_prefix": "ispc-v1.23.0-macOS.arm64",
        },
    },
    "1.28.2": {
        "linux": {
            "url": "https://github.com/ispc/ispc/releases/download/v1.28.2/ispc-v1.28.2-linux.tar.gz",
            "sha256": "32e611de1252cf1e09a6a13327f5746b8477f99e15ffa4cbd1b422386776688c",
            "strip_prefix": "ispc-v1.28.2-linux",
        },
        "windows": {
            "url": "https://github.com/ispc/ispc/releases/download/v1.28.2/ispc-v1.28.2-windows.zip",
            "sha256": "25966868d97a6f9bc38501b864883558994189446476584e5e491476d540de17",
            "strip_prefix": "ispc-v1.28.2-windows",
        },
        "osx_x86_64": {
            "url": "https://github.com/ispc/ispc/releases/download/v1.28.2/ispc-v1.28.2-macOS.x86_64.tar.gz",
            "sha256": "c3b613fb0250a4d2f89a08969068a294f5d1271fc8d0bd379529468e45ad49fb",
            "strip_prefix": "ispc-v1.28.2-macOS.x86_64",
        },
        "osx_arm64": {
            "url": "https://github.com/ispc/ispc/releases/download/v1.28.2/ispc-v1.28.2-macOS.arm64.tar.gz",
            "sha256": "45b5b16b1c24a65fc704cb8bf3f76f166b1dab733532c9ad60b4a024f9526414",
            "strip_prefix": "ispc-v1.28.2-macOS.arm64",
        },
    },
}

def fetch_ispc(version = "1.22.0"):
    """Fetches the remote prebuilt ISPC compiler for the specified version.
    
    Args:
        version: ISPC version to download. Supported versions: 1.22.0, 1.23.0.
                 Defaults to 1.22.0 for backward compatibility.
    """

    # See for download links https://ispc.github.io/downloads.html

    if version not in _ISPC_VERSIONS:
        fail("Unsupported ISPC version: {}. Supported versions: {}".format(
            version,
            ", ".join(_ISPC_VERSIONS.keys())
        ))

    version_data = _ISPC_VERSIONS[version]

    http_archive(
        name = "ispc_linux_x86_64",
        urls = [version_data["linux"]["url"]],
        sha256 = version_data["linux"]["sha256"],
        strip_prefix = version_data["linux"]["strip_prefix"],
        build_file = "@rules_ispc//:ispc_linux_x86_64.BUILD",
    )

    http_archive(
        name = "ispc_windows_x86_64",
        urls = [version_data["windows"]["url"]],
        sha256 = version_data["windows"]["sha256"],
        strip_prefix = version_data["windows"]["strip_prefix"],
        build_file = "@rules_ispc//:ispc_windows_x86_64.BUILD",
    )

    http_archive(
        name = "ispc_osx_x86_64",
        urls = [version_data["osx_x86_64"]["url"]],
        sha256 = version_data["osx_x86_64"]["sha256"],
        strip_prefix = version_data["osx_x86_64"]["strip_prefix"],
        build_file = "@rules_ispc//:ispc_osx_x86_64.BUILD",
    )
        
    http_archive(
        name = "ispc_osx_arm64",
        urls = [version_data["osx_arm64"]["url"]],
        sha256 = version_data["osx_arm64"]["sha256"],
        strip_prefix = version_data["osx_arm64"]["strip_prefix"],
        build_file = "@rules_ispc//:ispc_osx_arm64.BUILD",
    )
