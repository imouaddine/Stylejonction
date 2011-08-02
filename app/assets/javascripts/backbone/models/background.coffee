class Stylejonction.Models.Background extends Stylejonction.Models.Base
  paramRoot: ''
  url: ''
  
  initialize: ()->
    super

  background_url: ()->
    @.image.display_url()
  
  render: (element)->
    url = @.background_url()
    throw 'Url of background cannot be null' if url == null
    element.css("background-image", "url(#{url})")

class Stylejonction.Models.PredefinedBackground extends Stylejonction.Models.Background
  paramRoot: 'predefined_backgrounds'
  url: '/predefined_backgrounds/:id'
  
  initialize: (options)->
    super
    @type = "PredefinedBackground"
    @image = new Stylejonction.Models.Image(options.image)
    
    
  #against MVC pattern best practices but found it simple
  render: (element)->
    super
    element.addClass("cover_background") 
    
class Stylejonction.Models.PatternBackground extends Stylejonction.Models.Background
  paramRoot: 'pattern_backgrounds'
  url: '/pattern_backgrounds/:id'
  
  initialize: (options)->
    super
    @type = "PatternBackground"
    @pattern = new Stylejonction.Models.Pattern(options.pattern)
    
  background_url: ()->
    console.log @pattern.image
    @pattern.image.get('image').display.url
    
  render: (element)->
    color = @.get('color')
    
    element.css("background-image", "url(#{@.background_url()})")
    element.css("background-color", "##{color}")
   
    
class Stylejonction.Models.CustomBackground extends Stylejonction.Models.Background
  paramRoot: 'custom_background'
  url: '/custom_backgrounds/:id'
  
  initialize: (options)->
    super
    @type = "CustomBackground"
    @image = new Stylejonction.Models.Image(options.image)
    @ignored_attributes = ['image']
    
  render: (element)->
     super 
     display_mode = @.get("display_mode")
     switch display_mode
      when 'original'  
        element.addClass("original_background")
        element.removeClass("stretch_background")
        element.removeClass("tile_background")
      when 'stretch'  
        element.addClass("stretch_background")
        element.removeClass("original_background")
        element.removeClass("tile_background")
      when 'tile'  
        element.addClass("tile_background")
        element.removeClass("stretch_background")
        element.removeClass("original_background")
        

class Stylejonction.Models.BackgroundFactory
  create: (type, background)->
     switch type
        when 'PredefinedBackground' then back = new Stylejonction.Models.PredefinedBackground(background)
        when 'CustomBackground' then back = new Stylejonction.Models.CustomBackground(background)
        when 'PatternBackground' then back = new Stylejonction.Models.PatternBackground(background)
      back
     




