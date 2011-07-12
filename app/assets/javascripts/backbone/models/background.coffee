class Stylejonction.Models.Background extends Backbone.Model
  paramRoot: 'background'
  url: '/portfolio/background.json'

  initialize: ()->

  background_url: ()->
    @.get('background').url

  render: (element)->
    url = @.background_url()
    element.css("background-image", "url(#{url})")

class Stylejonction.Models.PredefinedBackground extends Stylejonction.Models.Background

  #against MVC pattern best practices but found it simple
  render: (element)->
    super
    element.addClass("cover_background") 
   
  
    
class Stylejonction.Models.PatternBackground extends Stylejonction.Models.Background
  render: (element)->
    #super 
    color = @.get('color')
    element.css("background-image", 'none')
    element.css("background-color", "##{color}")

    
    
class Stylejonction.Models.CustomBackground extends Stylejonction.Models.Background
  render: (element)->
     super 
     display_mode = @.get("display_mode")
     switch display_mode
      when 'original'  
        element.css("background-size", "auto")
        element.css("background-repeat", "none") 
        element.removeClass("cover_background")
      when 'stretch'  
        element.addClass("cover_background")
      when 'tile'  
        element.removeClass("cover_background")
        element.css("background-size", "auto") 
        element.css("background-repeat", "repeat") 

class Stylejonction.Models.BackgroundFactory
  create: (type, background)->
     switch type
        when 'PredefinedBackground' then back = new Stylejonction.Models.PredefinedBackground(background)
        when 'CustomBackground' then back = new Stylejonction.Models.CustomBackground(background)
        when 'PatternBackground' then back = new Stylejonction.Models.PatternBackground(background)
     back




