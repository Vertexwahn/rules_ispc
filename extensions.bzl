load("//:fetch_ispc.bzl", "fetch_ispc")

def _ispc_impl(ctx):
    fetch_ispc()

_download = tag_class(attrs = {})

ispc = module_extension(
    implementation = _ispc_impl,
    tag_classes = {
        "download": _download,
    }
)
