Stylejonction.Views.Projects ||= {}
class Stylejonction.Views.Projects.EditDocumentBlockView extends Backbone.View
  el: "#add_documents_section"
  events:
    "click  #save_document_btn" : "saveDocumentBlock"
  
  initialize: ()->
    _.bindAll(this, 'on_fancybox_complete')
    @.init_fancybox()  
    
  init_fancybox:()->
    $("#add_document, .edit_document").fancybox
      hideOnContentClick: false,
      showCloseButton: true,
      autoDimensions: true,
      autoScale: true,
      padding: 0,
      onComplete: @.on_fancybox_complete  
      
    $("#document_element_list").sortable(
      handle: '.drag_icon', 
      items: 'li',
      opacity: 0.4,
      scroll: true
    );
      
      
  on_fancybox_complete: ()->
    new Stylejonction.Views.Projects.EditDocumentView()
      
  
  saveDocumentBlock : (e) ->
    e.preventDefault()
    e.stopPropagation()
    
    if $("#document_block_title").val().trim().length == 0
      $("#document_block_title_error").show()
      return false 
    
    $("#document_block_weight").val($('#document_element_list').sortable('serialize'))
    console.log $('#document_element_list').sortable('serialize')
    $("#new_document_block, .edit_document_block").submit()


  