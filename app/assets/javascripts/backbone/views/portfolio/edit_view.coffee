Stylejonction.Views.Portfolios ||= {}

class Stylejonction.Views.Portfolios.EditView extends Backbone.View 

  events:
    "click .select_bg": "updateBackground"
    "click .select_layout": "updateLayout"
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
  
  updateLayout: (e) ->
    e.preventDefault()
    e.stopPropagation()
    target = $(e.currentTarget)
    newLayout = target.data('id')
    target.children(".select_loading_overlay").show()
    @.$("#layout_field .select_layout").removeClass("selected")
    @options.model.save({'layout_id': newLayout}, 
      success: -> 
        target.children(".select_loading_overlay").hide();
        $(e.currentTarget).addClass("selected")
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
