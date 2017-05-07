/**
 * Created by Bryan on 5/6/2017.
 */
$(function() {
    var assetdropzone;
    assetdropzone = new Dropzone("#asset-dropzone");
    return assetdropzone.on("success", function(file, responseText) {
        var imageUrl;
        imageUrl = responseText.file_name.url;
    });
});

Dropzone.options.assetDropzone={
    paramName: "asset[file_upload]",
};