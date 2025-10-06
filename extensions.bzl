load("//:fetch_ispc.bzl", "fetch_ispc")

def _ispc_impl(module_ctx):
    version = "1.22.0"  # Default version
    
    # Extract version from download tags
    found_proper_version = False
    for module in module_ctx.modules:
        for download_tag in module.tags.download:
            version = download_tag.version
            print("Fetching ISPC version: {}".format(version))
            found_proper_version = True
            break
        if found_proper_version:
            break
  
    fetch_ispc(version = version)

_download = tag_class(
    attrs = {
        "version": attr.string(
            doc = "ISPC version to download (e.g., '1.22.0' or '1.23.0'). Defaults to '1.22.0' for backward compatibility.",
            default = "1.22.0",
        ),
    }
)

ispc = module_extension(
    implementation = _ispc_impl,
    tag_classes = {
        "download": _download,
    }
)
