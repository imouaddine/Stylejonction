Stylejonction.Views.Backgrounds ||= {}

class Stylejonction.Views.Backgrounds.EditPatternView extends Backbone.View
  events:
    "change #portfolio_pattern_background_attributes_color"    : "updatePatternBackgroundColor"
    
  initialize: ()->
    init_colorpicker('#background_pattern_color_picker', '#portfolio_pattern_background_attributes_color')
    
    @portfolio = @options.portfolio
    @background = @options.model
    
    @.validatesParams()
    
 
  updatePatternBackgroundColor: (e)->
    e.preventDefault()
    e.stopPropagation()
    
    target = $(e.currentTarget)
    newColor = target.val()
    
    @.$("#pattern_preview").css("background-color", "##{newColor}" )
    @.$("#final_preview").css("background-color",   "##{newColor}" )
    
    @background.set({ 'color': newColor })
    @portfolio.trigger 'backgroundChanged', @background
      
    
    
  validatesParams: () ->
    if @portfolio not instanceof Stylejonction.Models.Portfolio
      debug.error 'Error. Portfolio object of EditPatternView is not valid'
      
    if @background not instanceof Stylejonction.Models.PatternBackground
      debug.error "Error. Background object of EditPatternView should PatternBackground #{this.background}"
     
    
    
  
    
    