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
    @.pattern_view = new Stylejonction.Views.Backgrounds.EditPatternView(
        model: @portfolio.pattern_background, 
        portfolio: @portfolio, 
        el: 'body'
    )
   
    
    #Edit background view 
    @.custom_view = new Stylejonction.Views.Backgrounds.EditCustomView(
      model: @portfolio.custom_background, 
      portfolio: @portfolio, 
      el: 'body'
    )
    
    #prefefined background view
    @.predefined_view = new Stylejonction.Views.Backgrounds.EditPredefinedView(
      model: @portfolio, 
      el: '#predefined_background_field'
    )
    #Color pickers
    #jcrop
  
       
  toggleCustomBackgroundSection: (e)->
    e.preventDefault()
    e.stopPropagation()
    val = $(e.currentTarget).val()
    visibleTab = $("##{val}")
    @.$("#update_custom_background").show()
    @.$("#custom_background_field .tabs > div").hide()
    visibleTab.show()
    if val == "update_custom_background" 
      custom_bg = @options.model.get('custom_background_id')
      #@.saveBackground('CustomBackground', custom_bg)
    else
      pattern_bg_id = @options.model.get('pattern_background_id')
      #@.saveBackground('PatternBackground', pattern_bg_id)
  
  showPredefinedBackgroundSection: (e)->
    e.preventDefault()
    e.stopPropagation()
    
    $("#predefined_background_field").css("margin-left", '0')
    $("#custom_background_field").css("margin-left", '-9999px')
    $("#layout_field").addClass("move_to_top")
    
    selected_predefined_bg = @options.model.get('predefined_background_id')
    @.saveBackground('PredefinedBackground', selected_predefined_bg)
    
    
    
   
    

   showCustomBackgroundSection: (e)->
     e.preventDefault()
     e.stopPropagation()
     
     $("#predefined_background_field").css("margin-left", '-9999px');
     $("#custom_background_field").css("margin-left", '0');
     $("#layout_field").removeClass("move_to_top"); 
     
     custom_bg = @options.model.get('custom_background_id')
     @.saveBackground('CustomBackground', custom_bg)
     
     $("#custom_background_input").attr('checked', 'checked');
     @.$("#custom_background_field .tabs > div").hide()
     $("#update_custom_background").show()
     

  saveBackground: (type, background_id) ->
     portfolio = @options.model
     backgroundFactory = @backgroundFactory
     
     background_attr = "predefined_background_id" if type == "PredefinedBackground"
     background_attr = "custom_background_id" if type == "CustomBackground"
     background_attr = "pattern_background_id" if type == "PatternBackground"
     
     portfolio.save(
        {
          "background_id": background_id, 
          "background_type": type
        },
        success: ->
          background = backgroundFactory.create( portfolio.get('background_type'), {id: background_id} )
          background.fetch(
            success: (newBackground) ->
              portfolio.trigger("backgroundChanged", newBackground)
          )
     )
     
     
       
  updateLayout: (e) ->
    e.preventDefault()
    e.stopPropagation()
    target = $(e.currentTarget)
    newLayout = target.data('id')
    @.$("#layout_field .image_link").removeClass("selected")
    @options.model.save({'layout': newLayout}, 
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
        $(e.currentTarget).addClass("selected")
    )
  
  
  

    

    
 
    
    
    
