// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require swfobject
//= require jquery.uploadify.v2.1.0.min
//= require underscore
//= require backbone
//= require backbone_rails_sync
//= require backbone_datalink
//= require backbone/stylejonction
//= require_tree .

$(window).bind("load", function() { 
  $("#preview_wrapper").pinFooter();
  initialOffset = $("#preview_wrapper").offset();
  initialHeight = $("#preview_wrapper").height();
});
$(window).bind("resize", function() { 
  $("#preview_wrapper").pinFooter();           
});
$(function(){
  $("#background_field").jcarousel({
      scroll :1,
      initCallback: init_carousel,
      buttonNextHTML: null,
      buttonPrevHTML: null
  });
})
function init_carousel(carousel){
  $('#left_scroll_bg').bind('click', function() {
      carousel.prev();
      return false;
  });
  $('#right_scroll_bg').bind('click', function() {
      carousel.next();
      return false;
  });
}
