Stylejonction.Views.Portfolios ||= {}

class Stylejonction.Views.Portfolios.EditView extends Backbone.View 

  events:
  
    "click  #predefined_background_field .toggle_btn"     : "showCustomBackgroundSection"
    "click  #custom_background_field .toggle_btn"         : "showPredefinedBackgroundSection"
    "change .custom_background_toggle"                    : "toggleCustomBackgroundSection"
    
    "click  #layout_field .image_link"                    : "updateLayout"
    
    "click  .select_theme":                           "updateTheme"
    "click  #title_font_field .select_font":          "updateTitleFont"
    "click  #body_font_field .select_font":           "updateBodyFont"
    "change  #color_picker_title_input":              "updateTitleColor"
    "change  #color_picker_body_input":               "updateBodyColor"

    
   
    
    
  
  initialize: (e)->
    #Color pickers
    @.init_colorpicker('#color_picker_title')
    @.init_colorpicker('#color_picker_body')
    @.init_colorpicker('#background_pattern_color_picker')
    
    #jcrop
    @.init_jcrop()
      
  init_colorpicker: (element) ->
    $(element).ColorPicker
         onChange: (hsb, hex, rgb) ->
           colorPkTitle = $(element).children("div")
           colorPkTitle.css('backgroundColor', '#' + hex)
           $(element+"_input").val(hex)
         
         onHide: (colpkr) ->
       	   $(element+"_input").trigger("change")
     .bind 'keyup', () =>
     	  $(this).ColorPickerSetColor(this.value)

     
 
       
  init_jcrop: ()->
    $('.cropbox').Jcrop
       aspectRatio: 0
       
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
    $("#layout_field").css("margin-top", '-220px')
    
    @selected_predefined_bg = @options.model.get('background_predefined_id')
    @options.model.save({'background_id': @selected_predefined_bg, 'background_type': 'PredefinedBackground'})
    
    

   showCustomBackgroundSection: (e)->
     e.preventDefault()
     e.stopPropagation()

     $("#predefined_background_field").css("margin-left", '-9999px');
     $("#custom_background_field").css("margin-left", '0');
     $("#layout_field").css("margin-top", '0'); 
     
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
  

    

    
 
    
    
    
