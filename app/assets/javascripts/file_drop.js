/**
 * Created by Bryan on 5/6/2017.
 */
$(function() {
    if (document.getElementById('asset-dropzone')) {
        var assetdropzone=Dropzone.forElement("#asset-dropzone");
     return assetdropzone.on("success", function(file, responseText) {
        var imageUrl;
        imageUrl = responseText.file_name.url;
        });
    }
});

Dropzone.options.assetDropzone={
    paramName: "asset[file_upload]"
};