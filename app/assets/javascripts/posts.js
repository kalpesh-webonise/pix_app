$(document).ready(function(){
    showHideCats();
    $('#post_category_id').click(function(){
        showHideCats();
    });


});
function showHideCats(){
    var category_id = $("#post_category_id").val();
    $(".disabledSelect select").hide().attr("disabled", true);
    $('#catID' + category_id).show().removeAttr('disabled');
}