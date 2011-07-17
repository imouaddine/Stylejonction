class Stylejonction.Models.Portfolio extends Backbone.Model
  paramRoot: 'portfolio'
  url: '/portfolio.json'
  
  defaults:
    layout: null
    theme: null
    
  initialize: (options)->
    @.url = @.url.replace ':id', @.id
    @body_font = new Stylejonction.Models.Font(options.body_font)
    @title_font = new Stylejonction.Models.Font(options.title_font)
    @background = new Stylejonction.Models.BackgroundFactory().create( @.get('background_type'), options.background )
    
    
  
