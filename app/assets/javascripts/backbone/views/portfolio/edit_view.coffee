Stylejonction.Views.Portfolios ||= {}

class Stylejonction.Views.Portfolios.EditView extends Backbone.View 

  events:
    "click  .select_bg":                            "updateBackground"
    "click  .select_layout":                        "updateLayout"
    "click  .select_theme":                         "updateTheme"
    "click  #title_font_field .select_font":        "updateTitleFont"
    "click  #body_font_field .select_font":         "updateBodyFont"
    "change  #portfolio_title_color":               "updateTitleColor"
    "change  #portfolio_body_color":                "updateBodyColor"
    
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
    target = $(e.currentTarget)
    newTheme = target.data('id')
    @.$("#theme_field .select_theme").removeClass("selected")
    @options.model.save({'theme': newTheme},
      success: -> 
        #target.children(".select_loading_overlay").hide();
        $(e.currentTarget).addClass("selected")
    
    )
  
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
    console.log "SSS"
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
