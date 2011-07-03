Stylejonction.Views.Portfolios ||= {}

class Stylejonction.Views.Portfolios.EditView extends Backbone.View 

  events:
    "click .select_bg": "updateBackground"
    "change #portfolio_theme": "updateTheme"
    "change #portfolio_theme": "updateFont"
    
  updateBackground: (e)->
    e.preventDefault()
    e.stopPropagation()
    target = $(e.currentTarget)
    newBackground = target.data('id')
    target.children(".select_loading_overlay").show()
    @.$("#background_field li").removeClass("selected")
    @options.model.save({'background_id': newBackground}, 
      success: -> 
        target.children(".select_loading_overlay").hide();
        
        $(e.currentTarget).parent().addClass("selected")
        
      
    )
    
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
