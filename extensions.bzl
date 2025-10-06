load("//:fetch_ispc.bzl", "fetch_ispc")

def _ispc_impl(ctx):
    # Get version from the first download tag, default to "1.22.0" for backward compatibility
    version = "1.22.0"
    for mod in ctx.modules:
        for download_tag in mod.tags.download:
            if download_tag.version:
                version = download_tag.version
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
