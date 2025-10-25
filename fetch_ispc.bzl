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
    "1.24.0": {
        "linux": {
            "url": "https://github.com/ispc/ispc/releases/download/v1.24.0/ispc-v1.24.0-linux.tar.gz",
            "sha256": "b3e5f71fd93aeaec7634179274b52572e59e700b8ff48c13d0f46708ee61a2c5",
            "strip_prefix": "ispc-v1.24.0-linux",
        },
        "windows": {
            "url": "https://github.com/ispc/ispc/releases/download/v1.24.0/ispc-v1.24.0-windows.zip",
            "sha256": "a7c21cb2434f5364acbdf0933af6de49198458ed6f0b62012e03c3325c972649",
            "strip_prefix": "ispc-v1.24.0-windows",
        },
        "osx_x86_64": {
            "url": "https://github.com/ispc/ispc/releases/download/v1.24.0/ispc-v1.24.0-macOS.x86_64.tar.gz",
            "sha256": "986eb172fe9db3e8da560e9d0d788832991638fab61ca80587d87eb175ffb520",
            "strip_prefix": "ispc-v1.24.0-macOS.x86_64",
        },
        "osx_arm64": {
            "url": "https://github.com/ispc/ispc/releases/download/v1.24.0/ispc-v1.24.0-macOS.arm64.tar.gz",
            "sha256": "7f3891d0157aed3cab159fbc5235235b62797053db9387f5a61c8d0a22369ae0",
            "strip_prefix": "ispc-v1.24.0-macOS.arm64",
        },
    },
    "1.25.0": {
        "linux": {
            "url": "https://github.com/ispc/ispc/releases/download/v1.25.0/ispc-v1.25.0-linux.tar.gz",
            "sha256": "1667976049abe6653d170de3f8a462799d57981ce46a161ccf59367f1177a028",
            "strip_prefix": "ispc-v1.25.0-linux",
        },
        "windows": {
            "url": "https://github.com/ispc/ispc/releases/download/v1.25.0/ispc-v1.25.0-windows.zip",
            "sha256": "a31987fd17f7435ca7ff1f7d7b8979a6972be9e8c6d391245b6b71c42c32d541",
            "strip_prefix": "ispc-v1.25.0-windows",
        },
        "osx_x86_64": {
            "url": "https://github.com/ispc/ispc/releases/download/v1.25.0/ispc-v1.25.0-macOS.x86_64.tar.gz",
            "sha256": "9097f02a95e68198ce41b9ca59cae6944f3df68e11987d1b86a041a55d720705",
            "strip_prefix": "ispc-v1.25.0-macOS.x86_64",
        },
        "osx_arm64": {
            "url": "https://github.com/ispc/ispc/releases/download/v1.25.0/ispc-v1.25.0-macOS.arm64.tar.gz",
            "sha256": "1d4474c65579e635cc2f45b87e779d4d821b5eac3b1f02ffe2a7529a29de436f",
            "strip_prefix": "ispc-v1.25.0-macOS.arm64",
        },
    },
    "1.25.1": {
        "linux": {
            "url": "https://github.com/ispc/ispc/releases/download/v1.25.1/ispc-v1.25.1-linux.tar.gz",
            "sha256": "5aad600fd4e13235fe0d7a00f69399fc6b1f6f04a6e4b933aa45da9a7f0f4434",
            "strip_prefix": "ispc-v1.25.1-linux",
        },
        "windows": {
            "url": "https://github.com/ispc/ispc/releases/download/v1.25.1/ispc-v1.25.1-windows.zip",
            "sha256": "160ef85f977075f4620e59f8970d25f2ce91a7492ebf8730ff9dc8310d23e33e",
            "strip_prefix": "ispc-v1.25.1-windows",
        },
        "osx_x86_64": {
            "url": "https://github.com/ispc/ispc/releases/download/v1.25.1/ispc-v1.25.1-macOS.x86_64.tar.gz",
            "sha256": "57a936a72131c114ce185dd65898b1f859fc0ffd2f540b3e139da5e6880a7070",
            "strip_prefix": "ispc-v1.25.1-macOS.x86_64",
        },
        "osx_arm64": {
            "url": "https://github.com/ispc/ispc/releases/download/v1.25.1/ispc-v1.25.1-macOS.arm64.tar.gz",
            "sha256": "9022f57bea609ec4a7fbb52b7625d401f30d982dbfbedc5b01e0a02cf94cec46",
            "strip_prefix": "ispc-v1.25.1-macOS.arm64",
        },
    },
    "1.25.2": {
        "linux": {
            "url": "https://github.com/ispc/ispc/releases/download/v1.25.2/ispc-v1.25.2-linux.tar.gz",
            "sha256": "41c98bde35c544d98864ceb12b42de927a14c2bd1a8fcb226feb22a8860db008",
            "strip_prefix": "ispc-v1.25.2-linux",
        },
        "windows": {
            "url": "https://github.com/ispc/ispc/releases/download/v1.25.2/ispc-v1.25.2-windows.zip",
            "sha256": "0a989eb0cbaccff3162b118c20ac74eda0381731dc8a59a8a967533e81b24928",
            "strip_prefix": "ispc-v1.25.2-windows",
        },
        "osx_x86_64": {
            "url": "https://github.com/ispc/ispc/releases/download/v1.25.2/ispc-v1.25.2-macOS.x86_64.tar.gz",
            "sha256": "aa4d65a76c86d5fe34b3f7fab1f54b0c69e6e37cb6918e12e6bafa437ac05896",
            "strip_prefix": "ispc-v1.25.2-macOS.x86_64",
        },
        "osx_arm64": {
            "url": "https://github.com/ispc/ispc/releases/download/v1.25.2/ispc-v1.25.2-macOS.arm64.tar.gz",
            "sha256": "1803f7f58c6c68f2dece679850b3e22ec0571dde3d428096dd292c302a6f3241",
            "strip_prefix": "ispc-v1.25.2-macOS.arm64",
        },
    },
    "1.25.3": {
        "linux": {
            "url": "https://github.com/ispc/ispc/releases/download/v1.25.3/ispc-v1.25.3-linux.tar.gz",
            "sha256": "4a89260cc1d216881735db4e60be72ca4630b8453f352b159867e215c85e1dbd",
            "strip_prefix": "ispc-v1.25.3-linux",
        },
        "windows": {
            "url": "https://github.com/ispc/ispc/releases/download/v1.25.3/ispc-v1.25.3-windows.zip",
            "sha256": "3a97e325f236c34a68013bf56fcb4e23c811b404207a60c010dc38fa24e60c55",
            "strip_prefix": "ispc-v1.25.3-windows",
        },
        "osx_x86_64": {
            "url": "https://github.com/ispc/ispc/releases/download/v1.25.3/ispc-v1.25.3-macOS.x86_64.tar.gz",
            "sha256": "6f35c5aec01a607c98d5661ef0f9e4d13665011247b17dfbc2f6a326120cb2aa",
            "strip_prefix": "ispc-v1.25.3-macOS.x86_64",
        },
        "osx_arm64": {
            "url": "https://github.com/ispc/ispc/releases/download/v1.25.3/ispc-v1.25.3-macOS.arm64.tar.gz",
            "sha256": "a2bc150402bb9523261063d45a0f0deae50900c62238ae031cf9b9530393a4ac",
            "strip_prefix": "ispc-v1.25.3-macOS.arm64",
        },
    },
    "1.26.0": {
        "linux": {
            "url": "https://github.com/ispc/ispc/releases/download/v1.26.0/ispc-v1.26.0-linux.tar.gz",
            "sha256": "a50e1d504a6e9bd719188ee57257d76475c8abee957ff9160307756c2a1bbe17",
            "strip_prefix": "ispc-v1.26.0-linux",
        },
        "windows": {
            "url": "https://github.com/ispc/ispc/releases/download/v1.26.0/ispc-v1.26.0-windows.zip",
            "sha256": "cffe9904d32260994fa264f8fca60eac7be9f8995c122bacf456a1c66ac72987",
            "strip_prefix": "ispc-v1.26.0-windows",
        },
        "osx_x86_64": {
            "url": "https://github.com/ispc/ispc/releases/download/v1.26.0/ispc-v1.26.0-macOS.x86_64.tar.gz",
            "sha256": "6c171c7aa85f5237a8c72091754a76c8b9d95119ec4c8cfe444c7c9a264eec5f",
            "strip_prefix": "ispc-v1.26.0-macOS.x86_64",
        },
        "osx_arm64": {
            "url": "https://github.com/ispc/ispc/releases/download/v1.26.0/ispc-v1.26.0-macOS.arm64.tar.gz",
            "sha256": "02f29de79643875fa4ba42eb46fc27bf6f36d931c8f11d6e9ae18a013388ab5d",
            "strip_prefix": "ispc-v1.26.0-macOS.arm64",
        },
    },
    "1.27.0": {
        "linux": {
            "url": "https://github.com/ispc/ispc/releases/download/v1.27.0/ispc-v1.27.0-linux.tar.gz",
            "sha256": "e9c3c653ff3241fce8e2f5c2f26fc1d8e80b8dd73a135bc59627221c00f4d30a",
            "strip_prefix": "ispc-v1.27.0-linux",
        },
        "windows": {
            "url": "https://github.com/ispc/ispc/releases/download/v1.27.0/ispc-v1.27.0-windows.zip",
            "sha256": "3cb34c0713e587ef33f0c52578df9e02154a577d053f2ba3326819e2bfc24728",
            "strip_prefix": "ispc-v1.27.0-windows",
        },
        "osx_x86_64": {
            "url": "https://github.com/ispc/ispc/releases/download/v1.27.0/ispc-v1.27.0-macOS.x86_64.tar.gz",
            "sha256": "bcb43ef21a25c3b6e89e71cf7024211c4f53c300ad840d051d9b19920248c94c",
            "strip_prefix": "ispc-v1.27.0-macOS.x86_64",
        },
        "osx_arm64": {
            "url": "https://github.com/ispc/ispc/releases/download/v1.27.0/ispc-v1.27.0-macOS.arm64.tar.gz",
            "sha256": "7a34c6c6406785748c95ba74e68d76557afd26ee513c327fcacc89eba588e690",
            "strip_prefix": "ispc-v1.27.0-macOS.arm64",
        },
    },
    "1.28.0": {
        "linux": {
            "url": "https://github.com/ispc/ispc/releases/download/v1.28.0/ispc-v1.28.0-linux.tar.gz",
            "sha256": "993ecc5b3d9b72a2dfa6ec96362a80a92ed4e1c4858d41dcab74cc9d64f9d3aa",
            "strip_prefix": "ispc-v1.28.0-linux",
        },
        "windows": {
            "url": "https://github.com/ispc/ispc/releases/download/v1.28.0/ispc-v1.28.0-windows.zip",
            "sha256": "727369f4477ea312bc9ab1b92911d7247a03ffaf83f39030d8d3e5fab08712ca",
            "strip_prefix": "ispc-v1.28.0-windows",
        },
        "osx_x86_64": {
            "url": "https://github.com/ispc/ispc/releases/download/v1.28.0/ispc-v1.28.0-macOS.x86_64.tar.gz",
            "sha256": "8ac7285bc6a7d7162289cbe175e6fd01a466be5f5136a2e66c05afa9a07bb657",
            "strip_prefix": "ispc-v1.28.0-macOS.x86_64",
        },
        "osx_arm64": {
            "url": "https://github.com/ispc/ispc/releases/download/v1.28.0/ispc-v1.28.0-macOS.arm64.tar.gz",
            "sha256": "741664b2edae3fcf94b38985e5cf5f18ad19a393f7e745577bdfe29d50ca6dd6",
            "strip_prefix": "ispc-v1.28.0-macOS.arm64",
        },
    },
    "1.28.1": {
        "linux": {
            "url": "https://github.com/ispc/ispc/releases/download/v1.28.1/ispc-v1.28.1-linux.tar.gz",
            "sha256": "00697aadb6e41e01568c9ef75446a0d3074ca05292c35c359f98a8fd27758791",
            "strip_prefix": "ispc-v1.28.1-linux",
        },
        "windows": {
            "url": "https://github.com/ispc/ispc/releases/download/v1.28.1/ispc-v1.28.1-windows.zip",
            "sha256": "230f0b1beeb333dc1e9fcdbac759869b362aab94db2285486ae6526d9160c52c",
            "strip_prefix": "ispc-v1.28.1-windows",
        },
        "osx_x86_64": {
            "url": "https://github.com/ispc/ispc/releases/download/v1.28.1/ispc-v1.28.1-macOS.x86_64.tar.gz",
            "sha256": "8c7fe14a3cc3ccc7f2b0717f00107a452cdfc2d68614ee986ed69a6f45e1a1c0",
            "strip_prefix": "ispc-v1.28.1-macOS.x86_64",
        },
        "osx_arm64": {
            "url": "https://github.com/ispc/ispc/releases/download/v1.28.1/ispc-v1.28.1-macOS.arm64.tar.gz",
            "sha256": "6a07c9087ae1d7fd41e785d9eafd6fd8cfa08d1354292df22ee003893ea48f64",
            "strip_prefix": "ispc-v1.28.1-macOS.arm64",
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
        version: ISPC version to download. Supported versions: 1.22.0, 1.23.0, 1.24.0, 1.25.0, 1.25.1, 1.25.2, 1.25.3, 1.26.0, 1.27.0, 1.28.0, 1.28.1, 1.28.2.
                 Defaults to 1.22.0 for backward compatibility.
    """

    # See for download links https://ispc.github.io/downloads.html

    if version not in _ISPC_VERSIONS:
        fail("Unsupported ISPC version: {}. Supported versions: {}".format(
            version,
            ", ".join(_ISPC_VERSIONS.keys()),
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
