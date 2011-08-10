Stylejonction.Views.Portfolios ||= {}

class Stylejonction.Views.Portfolios.EditLayoutView extends Backbone.View 
  events:
    
    "click  #predefined_background_field .toggle_btn"     : "showCustomBackgroundSection"
    "click  #custom_or_pattern_background_selection_field .toggle_btn"         : "showPredefinedBackgroundSection"
    "change .custom_background_toggle"                    : "toggleCustomBackgroundSection"
    "click  #layout_field .image_link"                    : "updateLayout"
    "click  .select_theme"                                :  "updateTheme"
   
  
  initialize: (e)->
    _.bindAll(this, 'updateCustomBackground', 'on_fancybox_complete')
    @portfolio = @options.model
    @portfolio.bind 'backgroundChanged', @.updateCustomBackground
    
   
    
    #Edit pattern view 
    @.pattern_view = new Stylejonction.Views.Backgrounds.EditPatternView(
        model: @portfolio.pattern_background, 
        portfolio: @portfolio, 
        el: 'body'
    )
    
    
    @.initializeFancybox()
   
    
    #prefefined background view
    @.predefined_view = new Stylejonction.Views.Backgrounds.EditPredefinedView(
      model: @portfolio, 
      el: '#predefined_background_field'
    )
   
  initializeFancybox: ->
    @.$(".edit_link").fancybox
      hideOnContentClick: false,
      showCloseButton: true,
      autoDimensions: true,
      autoScale: true,
      padding: 0,
      onComplete: @.on_fancybox_complete
  
  on_fancybox_complete: (e)->
    @.custom_view = new Stylejonction.Views.Backgrounds.EditCustomView(
      model: @portfolio.custom_background, 
      portfolio: @portfolio, 
      
    )
      
  toggleCustomBackgroundSection: (e)->
    e.preventDefault()
    e.stopPropagation()
    
    #hide tabs
    @.$("#custom_or_pattern_background_selection_field .tabs > section").hide()
    
    #display selected background section
    val = $(e.currentTarget).val()
    type = $(e.currentTarget).data('type')
    visibleTab = $("##{val}")
    visibleTab.show()
   
    switch val
      when 'update_custom_background'
        id = @portfolio.custom_background.get('id')
        $("#portfolio_background_id").val(id)
        $("#portfolio_custom_background_id").val(id)
        $("#portfolio_background_type").val("CustomBackground")
        @portfolio.trigger("backgroundChanged", @portfolio.custom_background)
      
      when 'update_pattern_background'
        id = @portfolio.pattern_background.get('id')
        $("#portfolio_background_id").val(id)
        $("#portfolio_pattern_background_id").val(id)
        $("#portfolio_background_type").val("PatternBackground")
        @portfolio.trigger("backgroundChanged", @portfolio.pattern_background)
    
    
  showPredefinedBackgroundSection: (e)->
      e.preventDefault()
      e.stopPropagation()
      #We're using margin instead of display:none as workaround to be able to display the carousel correctly
      $("#predefined_background_field").css("margin-left", '0')
      $("#custom_or_pattern_background_selection_field").css("margin-left", '-9999px')
      $("#layout_field").addClass("move_to_top")
    
    
      id = @portfolio.predefined_background.get('id')
      $("#portfolio_background_id").val(id)
      $("#portfolio_predefined_background_id").val(id)
      $("#portfolio_background_type").val("PredefinedBackground")
      
      @portfolio.trigger("backgroundChanged", @portfolio.predefined_background)
    
   
    

   showCustomBackgroundSection: (e)->
     e.preventDefault()
     e.stopPropagation()
     
     $("#predefined_background_field").css("margin-left", '-9999px');
     $("#custom_or_pattern_background_selection_field").css("margin-left", '0');
     $("#layout_field").removeClass("move_to_top"); 
     
     $("#custom_background_input").attr('checked', 'checked');
     @.$("#custom_or_pattern_background_selection_field .tabs > section").hide()
     $("#update_custom_background").show()
     
     id = @portfolio.custom_background.get('id')
     $("#portfolio_background_id").val(id)
     $("#portfolio_custom_background_id").val(id)
     $("#portfolio_background_type").val("CustomBackground")
     
     @portfolio.trigger("backgroundChanged", @portfolio.custom_background)
     
     
  updateCustomBackground: (e)->
    @portfolio.background = e
    switch e.type
      when "PredefinedBackground"
        background_attr = "#portfolio_predefined_background_id" 
        @portfolio.predefined_background = e
      when "CustomBackground"
        background_attr = "#portfolio_custom_background_id" 
        @portfolio.custom_background = e
        custom_background_id = e.get('id')
        $("#upload_custom_bg_links .edit_link").attr('href', "/custom_backgrounds/#{custom_background_id}/edit")
      when "PatternBackground"
        background_attr = "#portfolio_pattern_background_id" 
        @portfolio.pattern_background = e
    
    $(background_attr).val(e.get('id')) 
    $("#portfolio_background_id").val(e.get('id'))
    $("#portfolio_background_type").val(e.type)
    
  
    @.initializeFancybox()
    
    
  updateEditCustomBackgroundSection:(e) ->
    console.log e
    
        
  updateLayout: (e) ->
    e.preventDefault()
    e.stopPropagation()
    target = $(e.currentTarget)
    newLayout = target.data('id')
    @.$("#layout_field .image_link").removeClass("selected")
    $(e.currentTarget).addClass("selected")
    @options.model.set({'layout': newLayout})
    $("#portfolio_layout").val(newLayout)
    
    
  updateTheme: (e) ->
    e.preventDefault()
    e.stopPropagation()
    target = $(e.currentTarget)
    newTheme = target.data('id')
    @.$("#theme_field .select_theme").removeClass("selected")
    $(e.currentTarget).addClass("selected")
    @options.model.set({'theme': newTheme})
    $("#portfolio_theme").val(newTheme)
  
  
  
  

    

    
 
    
    
    
