# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  #MESSAGES
  window.messages = new Stylejonction.Messages()
  window.messages.hideAll()
  for type in window.messages.types
    if $(".#{type}.has_content").length > 0
      window.messages.show(type)



  #PREVIEW
  $("#preview_wrapper").draggable({ axis: "y" })
  $('#preview_wrapper').bind 'drag', (event, ui) =>
    offset = {left: 0, top: ui.offset.top}
    $("#preview_wrapper").offset(offset)
    $("#preview_wrapper").height( window.document_height - ui.offset.top )
    newHeight = window.document_height - ui.offset.top
    $("#preview").height( newHeight )

    delta =  ui.position.top - ui.originalPosition.top
    if( (delta > 0 && newHeight < 50) || ( (newHeight + 100) >=   window.document_height && delta < 0  ) )
      return false

  $("#dragger").dblclick ->
    $("#preview_wrapper").height(window.initialHeight)
    $("#preview_wrapper").animate({top: initialOffset.top}, 1000)

$(window).bind "load", () ->
    $("#preview_wrapper").pinFooter()
    window.initialOffset = $("#preview_wrapper").offset()
    window.initialHeight = $("#preview_wrapper").height()
    window.document_height = $(document).height();
    $("#remove_custom_background_btn").live 'ajax:success',  (evt, data, status, xhr) -> console.log data; eval(data)
      
    
    Backbone.history.start();

$(window).bind "resize", ()->
    $("#preview_wrapper").pinFooter()

window.init_colorpicker = (element, input) ->
  $(element).ColorPicker
       onChange: (hsb, hex, rgb) ->
         colorPkTitle = $(element).children("div")
         colorPkTitle.css('backgroundColor', '#' + hex)
         $(input).val(hex)

       onHide: (colpkr) ->
     	   $(input).trigger("change")
   .bind 'keyup', () =>
   	  $(this).ColorPickerSetColor(this.value)
















