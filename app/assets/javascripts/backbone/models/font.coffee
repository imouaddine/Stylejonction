class Stylejonction.Models.Font extends Backbone.Model
  paramRoot: 'font'
  url: '/fonts/:id.json'
  
  initialize: ()->
    @.url = @.url.replace ':id', @.id
  