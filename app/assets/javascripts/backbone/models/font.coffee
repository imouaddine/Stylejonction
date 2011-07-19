class Stylejonction.Models.Font extends Backbone.Model
  paramRoot: 'font'
  url: '/fonts/:id.json'
  
  initialize: ()->
    super
    @.url = @.url.replace ':id', @.id
  