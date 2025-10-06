# Example: Using ISPC version 1.23.0

This directory demonstrates how to use ISPC version 1.23.0 instead of the default 1.22.0.

## Steps to use ISPC 1.23.0:

1. In your `MODULE.bazel` file, modify the ISPC extension call:

```starlark
ispc = use_extension("@rules_ispc//:extensions.bzl", "ispc")
ispc.download(version = "1.23.0")  # Specify version 1.23.0

use_repo(
    ispc,
    "ispc_linux_x86_64",
    "ispc_windows_x86_64",
    "ispc_osx_x86_64",
    "ispc_osx_arm64"
)
```

2. Build your project normally:

```bash
bazel build //your:target
```

The build system will automatically download and use ISPC version 1.23.0 for all platforms.

## Switching back to 1.22.0:

Simply change the version parameter or remove it entirely (defaults to 1.22.0):

```starlark
ispc = use_extension("@rules_ispc//:extensions.bzl", "ispc")
ispc.download()  # Uses default version 1.22.0
```

or

```starlark
ispc = use_extension("@rules_ispc//:extensions.bzl", "ispc")
ispc.download(version = "1.22.0")  # Explicitly use version 1.22.0
```
