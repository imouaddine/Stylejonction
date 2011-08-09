Stylejonction.Views.Projects ||= {}
class Stylejonction.Views.Projects.EditPhotoView extends Backbone.View
  el: '#edit_photo_section'
  
  events:
    "click  #save_photo":          "save"
    "click #cancel_photo":         "cancel"
  
  
  cancel: (e)->
    e.preventDefault()
    e.stopPropagation()
    
    image_id = $("#photo_image_attributes_id").val()
    
    #$.post("/images/#{image_id}", { _method: 'delete' }, success: -> console.log("DELETED") )
    $.fancybox.cancel()
    $.fancybox.close()
    
    
      
  save: (e)->
    e.preventDefault()
    e.stopPropagation()
    
    object = @.$('#image_editor').data('viewer').img_object

    x = -object.x
    y = -object.y
    
    $("#crop_x").val(x)
    $("#crop_y").val(y)
    
    $("#new_photo, .edit_photo").submit()
    $.fancybox.close()
    

    
    