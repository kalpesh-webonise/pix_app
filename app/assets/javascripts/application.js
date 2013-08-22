// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
// Bootstrap JS files list - Adding only common required files in application.js
// Page specific boostrap file can be included in page using javascript_include_tag
/* bootstrap-alert.js     bootstrap-dropdown.js     bootstrap-tab.js     bootstrap-button.js
 bootstrap-modal.js     bootstrap-tooltip.js     bootstrap-carousel.js     bootstrap-popover.js
 bootstrap-transition.js     bootstrap-collapse.js     bootstrap-scrollspy.js     bootstrap-typeahead.js */
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap/bootstrap-alert
//= require twitter/bootstrap/bootstrap-button
//= require twitter/bootstrap/bootstrap-dropdown
//= require twitter/bootstrap/bootstrap-collapse
//= require jquery.fancybox
//= require posts
var flashTimer;
$(document).ready(function(){
  $(".back-to-top").hide();
  $(".navbar .container ul.nav li[rel='" + $(".activeTab").text() + "']").addClass("active");
  $(document).on("click", ".pagination ul li:not(.active) a", function(){
    toggleDoms($(".pagination").next("img"), $(".pagination"));
  });
  var offset = 280, duration = 500;
  $(window).scroll(function() {
    $(this).scrollTop() > offset ? $('.back-to-top').fadeIn(duration) : $('.back-to-top').fadeOut(duration);
  });
  $('.back-to-top').click(function(event) {
    $('html, body').animate({scrollTop: 0}, duration);
  });
  $(document).on("click", "a.page", function(){
    toggleDoms($("a.page"), $("img.page"));
  });
  $(".starImg").click(function(){
    var post_id=$(this).parent().attr("post_id");
    toggleDoms($('.favouriteStatus img.favLoader'), $(".starImg"));
    $.ajax({
      url: "/posts/" + post_id + "/mark_favourite",
      dataType: "SCRIPT",
      data: {fav: $(this).hasClass("favOff")},
      type: "PUT"
    });

  });
  hideFlash();
});

function toggleDoms(show, hide){
  show.show();
  hide.hide();
}
function displayFlash(message, type){
  var flash = "<div class='alert fade in " + type + "'><button data-dismiss='alert' class='close'>×</button>"
  flash += message + "</div>";
  $("div.alert").remove();
  if($(".actionLoader").length == 0)
    $('#contentBody').prepend(flash);
  else
    $(flash).insertAfter(".actionLoader");
  $(".actionLoader").hide();
}
function highlightFilter(selector){
  $("#" + selector).addClass("selected");
}
function hideFlash(){
  clearTimeout(flashTimer);
  flashTimer = setTimeout(function() {
    $(".alert").remove();
  }, 6000);
}