Stylejonction.Views.Projects ||= {}
class Stylejonction.Views.Projects.EditPhotoView extends Backbone.View
  el: '#edit_photo_section'
  
  events:
    "click  #save_photo":          "savePhoto"
    "completed #upload_custom_bg" : "on_photo_uploaded"
    
  savePhoto: (e)->
    e.preventDefault()
    e.stopPropagation()
    
    object = @.$('#image_editor').data('viewer').img_object

    x = -object.x
    y = -object.y
    
    $("#crop_x").val(x)
    $("#crop_y").val(y)
    
    $("#new_photo, .edit_photo").submit()
    $.fancybox.close()
    
  on_photo_uploaded: (e)->
    console.log "UPLOADED"
    
    