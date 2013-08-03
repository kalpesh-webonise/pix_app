$(document).ready(function(){
    showHideCats();
    $('#post_category_id').click(function(){
        showHideCats();
    });
  $(document).on("click", '.favouriteStatus .markFav', function(){
      $(".favouriteStatus ").html('<img src="/assets/starOn.png" class="starImg" alt="Staroff">');
    });
});
function showHideCats(){
    var category_id = $("#post_category_id").val();
    $(".disabledSelect select").hide().attr("disabled", true);
    $('#catID' + category_id).show().removeAttr('disabled');
}