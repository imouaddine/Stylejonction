class Stylejonction.Models.Photo extends Backbone.Model
  paramRoot: 'photo'
  url: '/galleries/:gallery_id/photos/:id.json'
  
  initialize: ()->
    super
    @.url = @.url.replace ':gallery_id', @.get('gallery_id')