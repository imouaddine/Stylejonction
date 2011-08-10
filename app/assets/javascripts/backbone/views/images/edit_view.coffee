Stylejonction.Views.Images ||= {}
class Stylejonction.Views.Images.EditView extends Backbone.View
  el: '#edit_image'
  
  events:
    "click #submit" : "submit"
    "click #cancel" : "cancel"
    
    
  initialize: (options)->
    @image = options.image
    
    
  submit: ->
    object = @.$('#image_editor').data('viewer').img_object;

    x = -object.x;
    y = -object.y;
    
    if $("#image_scale_to_fit").is(":checked")
      
      @image.save(
        {scale_to_fit: true }
        success: (e) -> 
          $.fancybox.close()
          
      )
    else
      $.post(
        "#{@image.url}/crop.json"
        {x: x, y: y }
        (data) ->
           @image = new Stylejonction.Models.Image(data)
           router.view.edit_cover_view.trigger('change', @image)
           $.fancybox.close()
           
      )
  
  
 
    
    
    
    
  cancel: ->
    $.fancybox.cancel()
    $.fancybox.close()
    
    
    
    
  
    
    
    
   
