# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  $("#preview_wrapper").draggable({ axis: "y" })
  $('#preview_wrapper').bind 'drag', (event, ui) =>
    offset = {left: 0, top: ui.offset.top}
    $("#preview_wrapper").offset(offset)
    $("#preview_wrapper").height( $(document).height() - ui.offset.top )
    newHeight = $(document).height() - ui.offset.top
    $("#preview").height( newHeight )
    if(newHeight < 50)
      return false
    
  $("#dragger").dblclick -> 
    $("#preview_wrapper").height(initialHeight)
    $("#preview_wrapper").animate({top: initialOffset.top}, 1000) 
  
$(window).bind "load", () ->
    $("#preview_wrapper").pinFooter()
    initialOffset = $("#preview_wrapper").offset()
    initialHeight = $("#preview_wrapper").height()

$(window).bind "resize", ()->
    $("#preview_wrapper").pinFooter()
    
window.init_colorpicker = (element) ->
  $(element).ColorPicker
       onChange: (hsb, hex, rgb) ->
         colorPkTitle = $(element).children("div")
         colorPkTitle.css('backgroundColor', '#' + hex)
         $(element+"_input").val(hex)

       onHide: (colpkr) ->
     	   $(element+"_input").trigger("change")
   .bind 'keyup', () =>
   	  $(this).ColorPickerSetColor(this.value)
  

    
  

  
    
      
   
    
    
    
      

  

  