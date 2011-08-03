class Stylejonction.Models.Image extends  Stylejonction.Models.Base
  paramRoot: 'image'
  url: '/images/:id'
  
  initialize: ()->
    super
    @parent = null
    @ignored_attributes = ['id', 'content_type', 'created_at', 'display_format_id', 'edit_format', 'preview_format', 'display_format', 'edit_format_id', 'file_size', 'height', 'id', 'preview_format_id', 'updated_at', 'uploaded', 'width', 'image', 'editable']
    
  display_url: ()->
    @.get('image').display.url
    
   