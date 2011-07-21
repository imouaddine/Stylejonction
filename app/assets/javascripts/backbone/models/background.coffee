class Stylejonction.Models.Background extends Stylejonction.Models.Base
  paramRoot: ''
  url: ''
  
  initialize: ()->
    super

  background_url: ()->
    @.get('background').url
  
  render: (element)->
    url = @.background_url()
    throw 'Url of background cannot be null' if url == null
    element.css("background-image", "url(#{url})")

class Stylejonction.Models.PredefinedBackground extends Stylejonction.Models.Background
  paramRoot: 'predefined_backgrounds'
  url: '/predefined_backgrounds/:id'
  
  #against MVC pattern best practices but found it simple
  render: (element)->
    super
    element.addClass("cover_background") 
  
  
  initialize: ()->
    super
    @type = "PredefinedBackground"
    
class Stylejonction.Models.PatternBackground extends Stylejonction.Models.Background
  paramRoot: 'pattern_backgrounds'
  url: '/pattern_backgrounds/:id'
   
  render: (element)->
    color = @.get('color')
    @pattern_id = @.get('pattern_id')
    @pattern = new Stylejonction.Models.Pattern({id: @pattern_id})
    @pattern.fetch(
      success: (pattern)->
        pattern_url = pattern.get('pattern').url
        element.css("background-image", "url(#{pattern_url})")
      error: ->
        debug.error "Cannot load pattern #{pattern_id}"
    )
    element.css("background-color", "##{color}")
  
  initialize: ->
    super
    @type = "PatternBackground"
   
   
    
class Stylejonction.Models.CustomBackground extends Stylejonction.Models.Background
  paramRoot: 'custom_backgrounds'
  url: '/custom_backgrounds/:id'
  
  initialize: ()->
    super
    @type = "CustomBackground"
    
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
     




