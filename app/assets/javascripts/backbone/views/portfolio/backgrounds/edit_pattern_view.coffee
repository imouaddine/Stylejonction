Stylejonction.Views.Backgrounds ||= {}

class Stylejonction.Views.Backgrounds.EditPatternView extends Backbone.View
  events:
    "change #background_pattern_color_picker_input"    : "updatePatternBackgroundColor"
    
  initialize: ()->
    init_colorpicker('#background_pattern_color_picker')
    

 
  updatePatternBackgroundColor: (e)->
    e.preventDefault()
    e.stopPropagation()
    target = $(e.currentTarget)
    newColor = target.val()
    @.$("#pattern_preview").css("background-color", "#"+newColor)
    @.$("#final_preview").css("background-color", "#"+newColor)
    
    @options.model.fetch(
      success: (e)->
        e.save({ 'color': newColor})
    )
    
  
    
    