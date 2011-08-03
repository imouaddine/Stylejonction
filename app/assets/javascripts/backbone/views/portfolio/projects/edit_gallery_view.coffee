Stylejonction.Views.Projects ||= {}
class Stylejonction.Views.Projects.EditGalleryView extends Backbone.View
  events:
    "click  .preference_link" : "updatePreference"
    "click #save_gallery_btn" : "saveGallery"

  initialize: ()->
    _.bindAll(this, 'on_fancybox_complete')
    @.init_fancybox()
  
  init_fancybox: ()->
    $(".iframe_fancy").fancybox
      hideOnContentClick: false,
      showCloseButton: true,
      autoDimensions: false
      width: 490,
      padding: 0,
      onComplete: @.on_fancybox_complete  
    
  on_fancybox_complete:()->
     new Stylejonction.Views.Projects.EditPhotoView({})
  
  updatePreference: (e)->
    e.preventDefault()
    e.stopPropagation()
    
    target = $(e.currentTarget)
    $(".preference_link").removeClass("selected")
    target.addClass("selected");
    preference = target.data('val')
    $("#gallery_display_preference").val(preference)
    
    
  
  saveGallery: (e)->
    $("#new_gallery, #edit_gallery").submit()
    
    
     
    
    
    
 