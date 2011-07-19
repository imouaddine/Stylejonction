Stylejonction.Views.Portfolios ||= {}

class Stylejonction.Views.Portfolios.EditLayoutView extends Backbone.View 
  events:
    
    "click  #predefined_background_field .toggle_btn"     : "showCustomBackgroundSection"
    "click  #custom_background_field .toggle_btn"         : "showPredefinedBackgroundSection"
    "change .custom_background_toggle"                    : "toggleCustomBackgroundSection"
    "click  #layout_field .image_link"                    : "updateLayout"
    "click  .select_theme"                                :  "updateTheme"
    
  
  initialize: (e)->
    _.bindAll(this, 'updateCustomBackground')
    @portfolio = @options.model
    @portfolio.bind 'backgroundChanged', @.updateCustomBackground
    
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
   
  
       
  toggleCustomBackgroundSection: (e)->
    e.preventDefault()
    e.stopPropagation()
    
    @.$("#custom_background_field .tabs > section").hide()
    
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
    
      $("#predefined_background_field").css("margin-left", '0')
      $("#custom_background_field").css("margin-left", '-9999px')
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
     $("#custom_background_field").css("margin-left", '0');
     $("#layout_field").removeClass("move_to_top"); 
     
     $("#custom_background_input").attr('checked', 'checked');
     @.$("#custom_background_field .tabs > section").hide()
     $("#update_custom_background").show()
     
     id = @portfolio.custom_background.get('id')
     $("#portfolio_background_id").val(id)
     $("#portfolio_custom_background_id").val(id)
     $("#portfolio_background_type").val("CustomBackground")
     
     @portfolio.trigger("backgroundChanged", @portfolio.custom_background)
     

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
  
  
  

    

    
 
    
    
    
