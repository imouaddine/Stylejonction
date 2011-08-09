Stylejonction.Views.Projects ||= {}
class Stylejonction.Views.Projects.EditDocumentBlockView extends Backbone.View
  el: "#add_documents_section"
  events:
    "click  #save_document_btn" : "saveDocumentBlock"
  
  initialize: ()->
    _.bindAll(this, 'on_fancybox_complete')
    @.init_fancybox()  
    
  init_fancybox:()->
    $("#add_document").fancybox
      hideOnContentClick: false,
      showCloseButton: true,
      autoDimensions: true,
      autoScale: true,
      padding: 0,
      onComplete: @.on_fancybox_complete  
      
      
  on_fancybox_complete: ()->
    new Stylejonction.Views.Projects.EditDocumentView()
      
  
  saveDocumentBlock : (e) ->
    e.preventDefault()
    e.stopPropagation()
    if $("#document_block_title").val().trim().length == 0
      $("#document_block_title_error").show()
      return false 
    
    
    $("#new_document_block, .edit_document_block").submit()


  