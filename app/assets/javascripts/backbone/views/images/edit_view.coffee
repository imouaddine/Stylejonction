Stylejonction.Views.Images ||= {}
class Stylejonction.Views.Images.EditView extends Backbone.View
  el: '#edit_image'
  
  events:
    "click #submit" : "submit"
    "click #cancel" : "cancel"
    
    
  initialize: (options)->
    _.bindAll(this, 'updateAndClose')
    @image = options.image
    
    
  submit: ->
    object = @.$('#image_editor').data('viewer').img_object;

    x = -object.x;
    y = -object.y;
    
    if $("#image_scale_to_fit").is(":checked")
      @image.save(
        {scale_to_fit: true }
        success: -> @.updateAndClose
      )
    else
      $.post(
        "#{@image.url}/crop.json"
        {x: x, y: y }
        @.updateAndClose
      )
  
  
  updateAndClose: (data) ->
    @image = new Stylejonction.Models.Image(data)
    @.trigger('change', @image)
    $.fancybox.close()
    
    
  cancel: ->
    $.fancybox.cancel()
    $.fancybox.close()
    
    
    
    
  
    
    
    
   
