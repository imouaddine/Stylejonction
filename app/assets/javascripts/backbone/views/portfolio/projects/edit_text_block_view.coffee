Stylejonction.Views.Projects ||= {}
class Stylejonction.Views.Projects.EditTextBlockView extends Backbone.View
  el: "#add_writing_section"
  events:
     "click  #save_text_block_btn" : "save"
     
  save: ->
    $("#new_text_block, .edit_text_block").submit()
    