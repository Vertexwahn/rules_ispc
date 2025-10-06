[![Support Ukraine](https://img.shields.io/badge/Support-Ukraine-FFD500?style=flat&labelColor=005BBB)](https://opensource.fb.com/support-ukraine)

# Bazel rules for Intel Implicit SPMD Program Compiler (ISPC)

Bazel build rules for [ISPC](https://ispc.github.io/).
Tested on Windows, Linux and macOS.

## Goal

The goal of these rules is to be able to use  [ISPC](https://ispc.github.io/) using [Bazel](https://bazel.build/) on Windows, 
Linux and macOS without the need to preinstall ISPC. 
All the magic to set up ISPC should be done by Bazel with as little effort as possible.

## ISPC Version Selection

This project supports multiple ISPC versions. You can select the version you need in your `MODULE.bazel` file:

**Supported versions:**
- `1.22.0` (default)
- `1.23.0`

**Usage in MODULE.bazel:**

```starlark
ispc = use_extension("@rules_ispc//:extensions.bzl", "ispc")

# Option 1: Use default version (1.22.0)
ispc.download()

# Option 2: Specify a version explicitly
ispc.download(version = "1.23.0")

use_repo(
    ispc,
    "ispc_linux_x86_64",
    "ispc_windows_x86_64",
    "ispc_osx_x86_64",
    "ispc_osx_arm64"
)
```

If no version is specified, version `1.22.0` will be used by default for backward compatibility.

## Quick start

This project uses [Bazel](https://bazel.build/) as a build system. 
The current used version of Bazel to test these rules is defined in [.bazelversion](tests/.bazelversion).
It is very likely that these rules work also with other Bazel versions,
since only very basic features are used (at least support for Bzlmod is required).

**Prerequisites:**

The following tools should be installed:

- [Git](https://git-scm.com/)
- [Bazel](https://bazel.build/install)
- A C++ compiler (GCC, Visual Studio, Clang, Apple Clang, etc.)

**Checkout, build, and run:**

```shell
git clone https://github.com/Vertexwahn/rules_ispc.git
cd rules_ispc
cd tests
bazel build //square:main
bazel run //square:main
```

## License

This work is published under [Apache 2.0 License](LICENSE).
