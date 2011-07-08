Stylejonction.Views.Portfolios ||= {}

class Stylejonction.Views.Portfolios.EditView extends Backbone.View 

  events:
    "click  #predefined_background_field .image_link"     : "updatePredefinedBackground"
    "click  #predefined_background_field .toggle_btn"     : "showCustomBackgroundSection"
    "click  #custom_background_field .toggle_btn"         : "showPredefinedBackgroundSection"
    
    
    "change .custom_background_toggle"                    : "toggleCustomBackgroundSection"
    
    "click  .select_layout":                           "updateLayout"
    "click  .select_theme":                           "updateTheme"
    "click  #title_font_field .select_font":          "updateTitleFont"
    "click  #body_font_field .select_font":           "updateBodyFont"
    "change  #color_picker_title_input":              "updateTitleColor"
    "change  #color_picker_body_input":               "updateBodyColor"
    "change  #own_color_picker_input":                "updatePatternBackgroundColor"
    
   
    "click #upload_custom_bg_links .edit_link"  :     "createBackgroundView"
    
  
  initialize: (e)->
    #Carousel
    start_position = @.$("#background_carousel li.selected").index()
    
    @.$("#background_carousel").jcarousel
      scroll :1,
      initCallback: @.init_carousel,
      buttonNextHTML: null,
      buttonPrevHTML: null
      start: start_position
      
    #Color pickers
    @.init_colorpicker('#color_picker_title')
    @.init_colorpicker('#color_picker_body')
    @.init_colorpicker('#own_color_picker')
    
    #fancybox
    @.init_fancybox()
    
    #jcrop
    @.init_jcrop()
    
    
    
    
    #event for elements outside the view
    #$("#edit_own_background").delegate "change", "input[name='display_mode']",  @.updateBgDisplayMode
   
      

  #background carousel
  init_carousel: (carousel) ->
    $('#left_scroll_bg').bind 'click', () =>
      carousel.prev()
      false
      
    $('#right_scroll_bg').bind 'click', () => 
      carousel.next()
      false;
      
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

     
  init_fancybox: ()->
    $(".iframe_fancy").fancybox
       hideOnContentClick: false,
       showCloseButton: true,
       padding: 0,
       
       
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
    
  
  updatePredefinedBackground: (e)->
    e.preventDefault()
    e.stopPropagation()
    target = $(e.currentTarget)
    newBackground = target.data('id')
    #target.children(".select_loading_overlay").show()
    @.$("#predefined_background_field .image_link").removeClass("selected")
    @.$("#predefined_background_field li").removeClass("selected")
    @options.model.save({'background_id': newBackground, 'background_type': 'PredefinedBackground'}, 
      success: -> 
        #target.children(".select_loading_overlay").hide();
        $(e.currentTarget).parent().addClass("selected")
        $(e.currentTarget).addClass("selected")
      error: ->
        alert 'Something wrong happened'
    )
  
  showPredefinedBackgroundSection: (e)->
    e.preventDefault()
    e.stopPropagation()
   
    $("#predefined_background_field").css("margin-left", '0');
    $("#custom_background_field").css("margin-left", '-9999px');
    
  showCustomBackgroundSection: (e)->
    e.preventDefault()
    e.stopPropagation()

    $("#predefined_background_field").css("margin-left", '-9999px');
    $("#custom_background_field").css("margin-left", '0');
    
    
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
  
  updatePatternBackgroundColor: (e)->
    e.preventDefault()
    e.stopPropagation()
    target = $(e.currentTarget)
    newColor = target.val()
    @.$("#pattern_preview").css("background-color", "#"+newColor);
    @.$("#final_preview").css("background-color", "#"+newColor);
    

    
  createBackgroundView: (e)->
    @background = new Stylejonction.Models.Background()
    @background.fetch()
    @background_edit_view = new Stylejonction.Views.Backgrounds.EditView(model: @background, el: '#edit_background')
    
    
    
    
