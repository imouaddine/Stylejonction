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
    
    $("#add_gallery_video").fancybox
      hideOnContentClick: false,
      showCloseButton: true,
      autoDimensions: true,
      autoScale: true,
      
      padding: 0,
      onComplete: @.on_fancybox_complete  
      
    $("#add_gallery_photo").fancybox
      hideOnContentClick: false,
      showCloseButton: true,
      autoDimensions: false
      width: 490,
      padding: 0,
      onComplete: @.on_fancybox_complete
  
  on_fancybox_complete:(e)->
    link_id = $(e).attr('id')
    if link_id == 'add_gallery_video'
      new Stylejonction.Views.Projects.EditVideoView()
    else if link_id == 'add_gallery_photo'
      new Stylejonction.Views.Projects.EditPhotoView()
  
  updatePreference: (e)->
    e.preventDefault()
    e.stopPropagation()
    
    target = $(e.currentTarget)
    $(".preference_link").removeClass("selected")
    target.addClass("selected");
    preference = target.data('val')
    $("#gallery_display_preference").val(preference)
  
  saveGallery: (e)->
    $("#gallery_weight").val($('#gallery_element_list').sortable('serialize'));
    $("#new_gallery, .edit_gallery").submit()
    
    
     
    
    
    
 