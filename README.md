[![Support Ukraine](https://img.shields.io/badge/Support-Ukraine-FFD500?style=flat&labelColor=005BBB)](https://opensource.fb.com/support-ukraine)

# Bazel rules for Intel Implicit SPMD Program Compiler (ISPC)

Bazel build rules for [ISPC](https://ispc.github.io/).
Tested on Windows, Linux and macOS.

## Goal

The goal of these rules is to be able to use  [ISPC](https://ispc.github.io/) using [Bazel](https://bazel.build/) on Windows, 
Linux and macOS without the need to preinstall ISPC. 
All the magic to set up ISPC should be done by Bazel with as little effort as possible.

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

## Releasing

Pushing a version tag such as `0.0.8` runs the release workflow, builds the examples,
creates a GitHub Release, and then opens a draft pull request to the
[Bazel Central Registry](https://github.com/bazelbuild/bazel-central-registry).
The BCR presubmit configuration is in `.bcr/presubmit.yml`.

Configure the `BCR_PUBLISH_TOKEN` Actions secret with a classic GitHub personal
access token that has `repo` and `workflow` permissions. The publish workflow uses
the `Vertexwahn/bazel-central-registry` fork and can be rerun manually from Actions
with the release tag if BCR publishing needs to be retried.

## License

This work is published under [Apache 2.0 License](LICENSE).
