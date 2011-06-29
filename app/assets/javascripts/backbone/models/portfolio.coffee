class Stylejonction.Models.Portfolio extends Backbone.Model
  paramRoot: 'portfolio'
  url: '/portfolio/:id/update'
  
  defaults:
    layout: null
    theme: null
    
  initialize: ()->
    @.url = @.url.replace ':id', @.id
    
  
