Stylejonction.Views.Projects ||= {}
class Stylejonction.Views.Projects.EditDocumentView extends Backbone.View
  el: '#edit_document_section'
  
  events:
    "click #save_document"    : "save"
    "click #cancel_document"  : "cancel"
    
  
  initialize: (e)->
    SI.Files.stylizeAll();
    $("#document_file").css("filter", "alpha(opacity=0)")
    $("#document_file").css("opacity", "0")
    $("input[type=file].multi").MultiFile()
    
    
  save: (e)->
    e.preventDefault()
    e.stopPropagation()
    $("#new_document, .edit_document").submit()
    
  
  cancel: (e)->
    e.preventDefault()
    e.stopPropagation()
    $.fancybox.cancel()
    $.fancybox.close()
    
    
    
      
  
  
    