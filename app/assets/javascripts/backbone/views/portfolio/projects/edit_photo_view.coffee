Stylejonction.Views.Projects ||= {}
class Stylejonction.Views.Projects.EditPhotoView extends Backbone.View
  el: '#edit_photo_section'
  
  events:
    "click  #save_photo":          "savePhoto"
    
  savePhoto: (e)->
    e.preventDefault()
    e.stopPropagation()
    
    $.fancybox.close()
    
    