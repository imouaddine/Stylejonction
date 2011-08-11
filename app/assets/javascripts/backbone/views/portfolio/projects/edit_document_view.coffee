Stylejonction.Views.Projects ||= {}
class Stylejonction.Views.Projects.EditDocumentView extends Backbone.View
  el: '#edit_document_section'
  
  events:
    "click #save_document"    : "save"
    "click #cancel_document"  : "cancel"
    
  
  initialize: (e)->
    SI.Files.stylizeAll();
    @.$("#document_file").css("filter", "alpha(opacity=0)")
    @.$("#document_file").css("opacity", "0")
    @.$("input[type=file].multi").MultiFile(
      max:1
    )
    
    
  save: (e)->
    e.preventDefault()
    e.stopPropagation()
    
    filename = $(".MultiFile-title").last().text()
    extension = filename.split('.').pop()
    if extension not in ['pptx', 'docx', 'xls', 'pdf', 'doc', 'ppt']
      @.$("#document_extension_error").show()
      return false
    
    if $("#document_caption").val().trim().length == 0
      @.$("#document_caption_error").show()
      return false
    
    $("#new_document, .edit_document").submit()
    
  
  cancel: (e)->
    e.preventDefault()
    e.stopPropagation()
    $.fancybox.cancel()
    $.fancybox.close()
    
    
    
      
  
  
    