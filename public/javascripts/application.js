$(function () {
    //open the invitation form when a share button is clicked 
    $( ".share a" )
        .button()
        .click(function() {
            //assign this specific Share link element into a variable called "a"
            var a = this;

            //First, set the title of the Dialog box to display the folder name
            $("#invitation_form").attr("title", "Share '" + $(a).attr("folder_name") + "' with others" );

            //a hack to display the different folder names correctly
            $("#ui-dialog-title-invitation_form").text("Share '" + $(a).attr("folder_name") + "' with others");

            //then put the folder_id of the Share link into the hidden field "folder_id" of the invite form
            $("#folder_id").val($(a).attr("folder_id"));

            //the dialog box customization
            $( "#invitation_form" ).dialog({
                height: 300,
                width: 600,
                modal: true,
                buttons: {
                    //First button
                    "Share": function() {
                        //get the url to post the form data to
                        var post_url = $("#invitation_form form").attr("action");

                        //serialize the form data and post it the url with ajax
                        $.post(post_url,$("#invitation_form form").serialize(), null, "script");

                        return false;
                    },
                    //Second button
                    Cancel: function() {
                        $( this ).dialog( "close" );
                    }
                },
                close: function() {

                }
            });

            return false;
        });
});