Stylejonction.Views.Portfolios ||= {}

class Stylejonction.Views.Portfolios.EditFontView extends Backbone.View 
  events:
   
    "click  #title_font_field .select_font":          "updateTitleFont"
    "click  #body_font_field .select_font":           "updateBodyFont"
    "change  #color_picker_title_input":              "updateTitleColor"
    "change  #color_picker_body_input":               "updateBodyColor"
    
    
  initialize: ()->
    init_colorpicker('#color_picker_title')
    init_colorpicker('#color_picker_body')
    
  updateTitleFont: (e)->
    e.preventDefault()
    e.stopPropagation()
    target = $(e.currentTarget)
    newFont = target.data('id')
    @.$("#title_font_field .select_font").removeClass("selected")
    @options.model.save({'title_font_id': newFont},
      success: -> 
        $(e.currentTarget).addClass("selected")
    )


  updateBodyFont: (e)->
    e.preventDefault()
    e.stopPropagation()
    target = $(e.currentTarget)
    newFont = target.data('id')
    @.$("#body_font_field .select_font").removeClass("selected")
    @options.model.save({'body_font_id': newFont},
      success: -> 
        $(e.currentTarget).addClass("selected")
    )
  updateTitleColor: (e)->
    e.preventDefault()
    e.stopPropagation()
    target = $(e.currentTarget)
    newColor = target.val()
    @options.model.save({'title_color': newColor})

  updateBodyColor: (e)->
    e.preventDefault()
    e.stopPropagation()
    target = $(e.currentTarget)
    newColor = target.val()
    @options.model.save({'body_color': newColor})