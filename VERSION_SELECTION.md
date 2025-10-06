# ISPC Version Selection Guide

This guide explains how to select different ISPC (Intel SPMD Program Compiler) versions when using `rules_ispc`.

## Supported Versions

The following ISPC versions are currently supported:

- **1.22.0** (default)
- **1.23.0**

## How to Select a Version

### In Your MODULE.bazel File

Add the ISPC extension and specify the version you want to use:

```starlark
bazel_dep(name = "rules_ispc", version = "0.0.5")

ispc = use_extension("@rules_ispc//:extensions.bzl", "ispc")

# Option 1: Use the default version (1.22.0)
ispc.download()

# Option 2: Explicitly specify version 1.22.0
ispc.download(version = "1.22.0")

# Option 3: Use version 1.23.0
ispc.download(version = "1.23.0")

use_repo(
    ispc,
    "ispc_linux_x86_64",
    "ispc_windows_x86_64",
    "ispc_osx_x86_64",
    "ispc_osx_arm64"
)
```

### Backward Compatibility

If you don't specify a version, the system will default to version **1.22.0** to maintain backward compatibility with existing projects.

## Platform Support

All supported ISPC versions are available for the following platforms:

- Linux (x86_64)
- Windows (x86_64)
- macOS (x86_64)
- macOS (arm64/Apple Silicon)

## Switching Between Versions

To switch between versions:

1. Update the `version` parameter in the `ispc.download()` call in your `MODULE.bazel`
2. Run `bazel clean` to ensure a fresh build (optional but recommended)
3. Build your project as usual

Example:

```starlark
# Change from:
ispc.download(version = "1.22.0")

# To:
ispc.download(version = "1.23.0")
```

## Version Information

### Version 1.22.0
- Default version for backward compatibility
- Stable and well-tested

### Version 1.23.0
- Latest supported version
- May include newer features and improvements

For more information about ISPC versions and their features, visit the [official ISPC downloads page](https://ispc.github.io/downloads.html).
