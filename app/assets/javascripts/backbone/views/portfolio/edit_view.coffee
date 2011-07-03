Stylejonction.Views.Portfolios ||= {}

class Stylejonction.Views.Portfolios.EditView extends Backbone.View 

  events:
    "click .select_bg": "updateBackground"
    "change #portfolio_theme": "updateTheme"
    "change #portfolio_theme": "updateFont"
    
  updateBackground: (e)->
    e.preventDefault()
    e.stopPropagation()
    @options.model.save({'background': 1})
    
  updateTheme: (e) ->
    e.preventDefault()
    e.stopPropagation()
    newTheme = $("#portfolio_theme").val()
    @options.model.save({'theme': newTheme})
  
  updateFont: (e)->
    e.preventDefault()
    e.stopPropagation()
    newFont = $("#portfolio_font").val()
    @options.model.save({'font': newFont})
