# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  $("#separator").draggable({ axis: "y" })
    
  $('#separator').bind 'drag', (event, ui) =>
      console.log ui
      offset = {left: 0, top: -ui.position.top}
      $("#preview_wrapper").offset(offset)
      $("#preview_wrapper").height(ui.offset.top)
      $("#preview").height(ui.offset.top)
  