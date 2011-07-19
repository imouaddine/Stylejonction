Stylejonction.Views.Portfolios ||= {}

class Stylejonction.Views.Portfolios.EditFontView extends Backbone.View 
  events:
    "click  #title_font_field .select_font":          "updateTitleFont"
    "click  #body_font_field .select_font":           "updateBodyFont"
    "change  #portfolio_title_color":              "updateTitleColor"
    "change  #portfolio_body_color":               "updateBodyColor"
    
    
  initialize: ()->
    init_colorpicker('#color_picker_title', "#portfolio_title_color")
    init_colorpicker('#color_picker_body', "#portfolio_body_color")
    
  updateTitleFont: (e)->
    e.preventDefault()
    e.stopPropagation()
    target = $(e.currentTarget)
    newFont = target.data('id')
    @.$("#title_font_field .select_font").removeClass("selected")
    @options.model.set({'title_font_id': newFont})
    $(e.currentTarget).addClass("selected")
    $("#portfolio_title_font_id").val(newFont)


  updateBodyFont: (e)->
    e.preventDefault()
    e.stopPropagation()
    target = $(e.currentTarget)
    newFont = target.data('id')
    @.$("#body_font_field .select_font").removeClass("selected")
    $(e.currentTarget).addClass("selected")
    @options.model.set({'body_font_id': newFont})
    $("#portfolio_body_font_id").val(newFont)
    
  updateTitleColor: (e)->
    e.preventDefault()
    e.stopPropagation()
    target = $(e.currentTarget)
    newColor = target.val()
    @options.model.set({'title_color': newColor})
   

  updateBodyColor: (e)->
    e.preventDefault()
    e.stopPropagation()
    target = $(e.currentTarget)
    newColor = target.val()
    @options.model.set({'body_color': newColor})
   