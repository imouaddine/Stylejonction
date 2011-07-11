class Stylejonction.Models.Background extends Backbone.Model
  paramRoot: 'background'
  url: '/portfolio/background.json'
  
  initialize: ()->
    
  background_url: ()->
    @.get('background').url
    
    
class Stylejonction.Models.PredefinedBackground extends Stylejonction.Models.Background
  
  #against MVC pattern best practices but found it simple
  render: (element)->
    url = @.background_url()
    element.css("background-image", "url(#{url})")
    console.log element.css("background-image")
    return

    
class Stylejonction.Models.PatternBackground extends Stylejonction.Models.Background
  render: (element)->
    
    
class Stylejonction.Models.CustomBackground extends Stylejonction.Models.Background
  render: (element)->
     url = @.background_url()
     element.css("background-image", "url(#{url})")
     display_mode = element.get("display_mode")
    
    
class Stylejonction.Models.BackgroundFactory
  create: (type, background)->
     switch type
        when 'PredefinedBackground' then back = new Stylejonction.Models.PredefinedBackground(background)
        when 'CustomBackground' then back = new Stylejonction.Models.CustomBackground(background)
        when 'PatternBackground' then back = new Stylejonction.Models.PatternBackground(background) 
     back
    
    

    
    
  
    

   