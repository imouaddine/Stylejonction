class Stylejonction.Models.Portfolio extends Backbone.Model
  paramRoot: 'portfolio'
  url: '/portfolio/update'
  
  defaults:
    layout: null
    theme: null
    
  initialize: ()->
    @.url = @.url.replace ':id', @.id
    
  
