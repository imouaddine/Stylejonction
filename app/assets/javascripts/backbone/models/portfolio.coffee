class Stylejonction.Models.Portfolio  extends  Stylejonction.Models.Base
  paramRoot: 'portfolio'
  url: '/portfolio.json'
  
  defaults:
    layout: "left"
    theme: "light"
    
  initialize: (options)->
    super
    @body_font = new Stylejonction.Models.Font(options.body_font)
    @title_font = new Stylejonction.Models.Font(options.title_font)
    @pattern_background = new Stylejonction.Models.PatternBackground(options.pattern_background)
    @predefined_background = new Stylejonction.Models.PredefinedBackground(options.predefined_background)
    @custom_background = new Stylejonction.Models.CustomBackground(options.custom_background)
    switch @.get('background_type')
      when 'PatternBackground' 
        @background = @pattern_background 
      when 'CustomBackground'
        @background = @custom_background 
      when 'PredefinedBackground'
        @background = @predefined_background 
    @ignored_attributes = ['body_font', 'title_font', 'background', 'custom_background', 'pattern_background', 'predefined_background']
    
    
 
  
        
   
   
    
    
    
    
    
  
