Stylejonction.Views.Projects ||= {}
class Stylejonction.Views.Projects.EditGalleryView extends Backbone.View
  events:
    "click  .preference_link" : "updatePreference"
    "click #save_gallery_btn" : "saveGallery"

  initialize: ()->
    _.bindAll(this, 'on_fancybox_complete')
    @.init_fancybox()
    $('#gallery_pane').jScrollPane({showArrows:true});
    $("#gallery_element_list").sortable(
      handle: '.drag_icon', 
      items: 'li',
      opacity: 0.4,
      scroll: true
    );
    
  init_fancybox: ()->
    $(".iframe_fancy").fancybox
      hideOnContentClick: false,
      showCloseButton: true,
      autoDimensions: false
      width: 490,
      padding: 0,
      onComplete: @.on_fancybox_complete  
    
  on_fancybox_complete:()->
    gallery_id = $("#gallery_id").val()
    photo = new Stylejonction.Models.Photo({gallery_id: gallery_id})
    new Stylejonction.Views.Projects.EditPhotoView(photo)
  
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
    
    
     
    
    
    
 