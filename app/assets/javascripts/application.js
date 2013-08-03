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
//= require jquery.history
$(document).ready(function(){
  $(".back-to-top").hide();
  $('.dropdown-toggle').dropdown();
  $(".navbar .container ul.nav li[rel='" + $(".activeTab").text() + "']").addClass("active");
  $(document).on("click", ".pagination ul li:not(.active) a", function(){
    toggleDoms($(".pagination").next("img"), $(".pagination"));
  });
  $.ajaxSetup({
    error: function (XMLHttpRequest, textStatus, errorThrown) {
      $(".actionLoader").hide();
      console.log(errorThrown);
      console.log(textStatus);
      displayFlash(((XMLHttpRequest.status == 0) ? "Sorry, request can no be completed, We are unable to connect to the Server" : "Something went wrong, please try this feature after some time, we have been notified about this issue!"), 'alert-error');
    }
  });

  if(isHtml5Supported()){
    History.Adapter.bind(window, 'statechange', function(e) {
      var window_url = window.location.pathname, current_url = $('#pathname').text();
      if(window_url != current_url)
        sendUpdateRequest(window_url);
    });
//    $(document).on("click", "a.ajaxify", function(e){
//      e.preventDefault();
//      var url=$(this).attr("href");
//      sendUpdateRequest(url);
//    });
  }
   var offset = 280, duration = 500;
  $(window).scroll(function() {
    $(this).scrollTop() > offset ? $('.back-to-top').fadeIn(duration) : $('.back-to-top').fadeOut(duration);
  });
  $('.back-to-top').click(function(event) {
    $('html, body').animate({scrollTop: 0}, duration);
  })
});
function sendUpdateRequest(url){
  $(".actionLoader").show();
  $.ajax({
    url: url,
    dataType: "SCRIPT",
    headers: { 'x-ajax-request': 'true' },
    success: function(){
      if($(".actionLoader").length == 0)
        $("#contentBody").prepend('<div class="actionLoader"></div>');
    },
    statusCode: {
      401: function() {
        window.location = url;
      }
    }
  });
}
function toggleDoms(show, hide){
  show.show();
  hide.hide();
}
function updatePage(body, title, tab, url, notice, message){
  $("#contentBody").html(body);
  $(".navbar .container ul.nav li").removeClass("active");
  $(".navbar .container ul.nav li[rel='" + tab + "']").addClass("active");
  History.pushState({state:1}, title,  url);
  if(notice)
    displayFlash(message, 'alert-success');
}
function isHtml5Supported(){
  if ((navigator.appVersion.indexOf("MSIE 10") != -1) || (navigator.appName != "Microsoft Internet Explorer"))
    return true;
  else
    return false;
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