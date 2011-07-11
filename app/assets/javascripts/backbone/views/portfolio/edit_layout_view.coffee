Stylejonction.Views.Portfolios ||= {}

class Stylejonction.Views.Portfolios.EditLayoutView extends Backbone.View 
  events:
    
    "click  #predefined_background_field .toggle_btn"     : "showCustomBackgroundSection"
    "click  #custom_background_field .toggle_btn"         : "showPredefinedBackgroundSection"
    "change .custom_background_toggle"                    : "toggleCustomBackgroundSection"
    "click  #layout_field .image_link"                    : "updateLayout"
    "click  .select_theme"                                :  "updateTheme"
  
  initialize: (e)->
    @portfolio = @options.model
    
    #Edit pattern view 
    background = new Stylejonction.Models.PatternBackground({id: @portfolio.pattern_background_id})
    background.fetch()
    @custom_background_edit_view = new Stylejonction.Views.Backgrounds.EditPatternView(model: background, el: 'body')
    
    #Edit background view 
    background = new Stylejonction.Models.CustomBackground({id: @portfolio.custom_background_id})
    background.fetch()
    @custom_background_edit_view = new Stylejonction.Views.Backgrounds.EditCustomView(model: background, el: 'body')
    
    #prefefined background view
    @custom_background_edit_view = new Stylejonction.Views.Backgrounds.EditPredefinedView(model: @portfolio, el: '#predefined_background_field')
    
    #Color pickers
    #jcrop
  
       
  toggleCustomBackgroundSection: (e)->
    e.preventDefault()
    e.stopPropagation()
    val = $(e.currentTarget).val()
    visibleTab = $("##{val}")
    @.$("#custom_background_field .tabs > div").hide()
    visibleTab.show()
    if( val == "update_custom_background" )
      custom_bg = @options.model.get('custom_background_id')
      @options.model.save({'background_id': custom_bg, 'background_type': 'CustomBackground'})
    else
      pattern_bg_id = @options.model.get('pattern_background_id')
      @options.model.save({'background_id': pattern_bg_id, 'background_type': 'PatternBackground'})
    
    
    
    
  
  showPredefinedBackgroundSection: (e)->
    e.preventDefault()
    e.stopPropagation()

    $("#predefined_background_field").css("margin-left", '0')
    $("#custom_background_field").css("margin-left", '-9999px')
    $("#layout_field").addClass("move_to_top")
    
    @selected_predefined_bg = @options.model.get('background_predefined_id')
    @options.model.save({'background_id': @selected_predefined_bg, 'background_type': 'PredefinedBackground'})
    
    

   showCustomBackgroundSection: (e)->
     e.preventDefault()
     e.stopPropagation()

     $("#predefined_background_field").css("margin-left", '-9999px');
     $("#custom_background_field").css("margin-left", '0');
     $("#layout_field").removeClass("move_to_top"); 
     
     @custom_bg = @options.model.get('custom_background_id')
     @options.model.save({'background_id': @custom_bg, 'background_type': 'CustomBackground'}) 
     
     
  

    
  updateLayout: (e) ->
    e.preventDefault()
    e.stopPropagation()
    target = $(e.currentTarget)
    newLayout = target.data('id')
    @.$("#layout_field .image_link").removeClass("selected")
    @options.model.save({'layout_id': newLayout}, 
      success: -> 
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
  
  
  

    

    
 
    
    
    
