[![Support Ukraine](https://img.shields.io/badge/Support-Ukraine-FFD500?style=flat&labelColor=005BBB)](https://opensource.fb.com/support-ukraine)

# Bazel rules for Intel Implicit SPMD Program Compiler (ISPC)

Experimental Bazel build rules for [ISPC](https://ispc.github.io/).

## Goal 

The goal of these rules is to be able to use  [ISPC](https://ispc.github.io/) using [Bazel](https://bazel.build/) on Windows, 
Linux and macOS without the need to preinstall ISPC. 
All the magic to set up ISPC should be done by Bazel with as little effort as possible.

## Quick start

This project uses [Bazel](https://bazel.build/) as a build system. 
The current used version of Bazel is defined in [.bazelversion](tests/.bazelversion).

**Prerequisites:**

The following tools should be installed:
- [Git](https://git-scm.com/)
- [Bazel](https://bazel.build/install)
- A C++ compiler (GCC, Visual Studio, Clang, etc.)

**Checkout, build, and run:**

```shell
git clone https://github.com/Vertexwahn/rules_ispc.git
cd rules_ispc
cd tests
bazel build //square:main
bazel run //square:main
```

## License

This work is published under Apache 2.0 License.

