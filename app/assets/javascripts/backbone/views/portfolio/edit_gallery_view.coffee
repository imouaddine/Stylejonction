class Stylejonction.Views.EditGalleryView extends Backbone.View
  events:
    "click  .preference_link" : "updatePreference"
    "click #save_gallery_btn" : "saveGallery"

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
    
    
     
    
    
    
 