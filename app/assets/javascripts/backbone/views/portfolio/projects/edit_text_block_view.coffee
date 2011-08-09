Stylejonction.Views.Projects ||= {}
class Stylejonction.Views.Projects.EditTextBlockView extends Backbone.View
  el: "#add_writing_section"
  events:
     "click  #save_text_block_btn" : "save"
     
     
  initialize: ->
    $("#text_block_body").wysiwyg(
        rmUnusedControls: true,
        css: '/editor.css',
        iFrameClass: "wysiwyg-input",
        initialContent: "<p>Content goes here...</p>",
        controls: 
          bold: { visible: true },
          italic: { visible: true },
          underline: { visible: true },
          insertOrderedList: { visible: true },
          insertUnorderedList: { visible: true },
          indent: { visible: true },
          outdent: { visible: true },
          quote: { visible: false, tags: ['blockquote'], css: { class: 'quote', className: 'quote' } },
          justifyLeft: {visible: true},
          justifyCenter: {visible: true},
          justifyRight: {visible: true}
    );
    
  save: (e)->
    e.preventDefault()
    e.stopPropagation()
  
    if $("#text_block_title").val().trim().length == 0
      $("#text_block_title_error").show()
      return false
    $("#new_text_block, .edit_text_block").submit()
    