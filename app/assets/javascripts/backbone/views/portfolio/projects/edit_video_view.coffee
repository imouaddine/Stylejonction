Stylejonction.Views.Projects ||= {}
class Stylejonction.Views.Projects.EditVideoView extends Backbone.View
  el: '#edit_video_section'
  
  events:
    "click  #save_video":          "save"
    
  save: (e)->
    e.preventDefault()
    e.stopPropagation()
    $("#new_video, #edit_video").submit()
    $.fancybox.close()
    
