# Migration Guide: Upgrading to Version-Selectable ISPC

## Overview

This guide helps users understand the changes in the new version-selectable ISPC feature and how to migrate existing projects.

## What Changed?

### Before (Old Approach)
Previously, ISPC version 1.22.0 was hardcoded and users had no choice:

```starlark
# MODULE.bazel (old)
ispc = use_extension("@rules_ispc//:extensions.bzl", "ispc")
ispc.download()  # Always downloaded version 1.22.0
```

### After (New Approach)
Now users can select between versions 1.22.0 and 1.23.0:

```starlark
# MODULE.bazel (new - default behavior unchanged)
ispc = use_extension("@rules_ispc//:extensions.bzl", "ispc")
ispc.download()  # Still defaults to 1.22.0 for backward compatibility

# MODULE.bazel (new - explicit version 1.23.0)
ispc = use_extension("@rules_ispc//:extensions.bzl", "ispc")
ispc.download(version = "1.23.0")  # Use newer version
```

## Do I Need to Change Anything?

**No, if you want to keep using version 1.22.0.**

The default behavior remains unchanged. Existing projects will continue to work without any modifications.

**Yes, if you want to use version 1.23.0.**

Simply add the `version` parameter to your `ispc.download()` call.

## Migration Steps

### For Projects Staying on 1.22.0

No action required! Your existing configuration will continue to work:

```starlark
ispc = use_extension("@rules_ispc//:extensions.bzl", "ispc")
ispc.download()
```

### For Projects Upgrading to 1.23.0

1. Open your `MODULE.bazel` file
2. Locate the `ispc.download()` line
3. Add the version parameter:

```starlark
# Change from:
ispc.download()

# To:
ispc.download(version = "1.23.0")
```

4. (Optional but recommended) Run `bazel clean` to ensure a fresh build
5. Build your project normally

## Example: Complete MODULE.bazel

### Using Default Version (1.22.0)

```starlark
module(name = "my_project", version = "1.0.0")

bazel_dep(name = "rules_ispc", version = "0.0.5")
bazel_dep(name = "platforms", version = "1.0.0")
bazel_dep(name = "rules_cc", version = "0.1.4")

ispc = use_extension("@rules_ispc//:extensions.bzl", "ispc")
ispc.download()  # Uses default version 1.22.0

use_repo(
    ispc,
    "ispc_linux_x86_64",
    "ispc_windows_x86_64",
    "ispc_osx_x86_64",
    "ispc_osx_arm64"
)

register_toolchains("@rules_ispc//tools:all")
```

### Using Version 1.23.0

```starlark
module(name = "my_project", version = "1.0.0")

bazel_dep(name = "rules_ispc", version = "0.0.5")
bazel_dep(name = "platforms", version = "1.0.0")
bazel_dep(name = "rules_cc", version = "0.1.4")

ispc = use_extension("@rules_ispc//:extensions.bzl", "ispc")
ispc.download(version = "1.23.0")  # Explicitly use version 1.23.0

use_repo(
    ispc,
    "ispc_linux_x86_64",
    "ispc_windows_x86_64",
    "ispc_osx_x86_64",
    "ispc_osx_arm64"
)

register_toolchains("@rules_ispc//tools:all")
```

## Version Comparison

| Feature | Version 1.22.0 | Version 1.23.0 |
|---------|---------------|----------------|
| Status | Default | Optional |
| Backward Compatible | Yes | Yes |
| Linux Support | ✅ | ✅ |
| Windows Support | ✅ | ✅ |
| macOS x86_64 Support | ✅ | ✅ |
| macOS arm64 Support | ✅ | ✅ |

## Troubleshooting

### Error: "Unsupported ISPC version"

If you see this error, you've specified a version that isn't supported. Currently supported versions are:
- 1.22.0
- 1.23.0

**Solution**: Use one of the supported versions or omit the version parameter to use the default.

### Build fails after switching versions

**Solution**: Run `bazel clean` and try again:

```bash
bazel clean
bazel build //your:target
```

## Questions?

For more information, see:
- [VERSION_SELECTION.md](VERSION_SELECTION.md) - Detailed version selection guide
- [EXAMPLE_VERSION_123.md](EXAMPLE_VERSION_123.md) - Quick example for version 1.23.0
- [README.md](README.md) - General project documentation
