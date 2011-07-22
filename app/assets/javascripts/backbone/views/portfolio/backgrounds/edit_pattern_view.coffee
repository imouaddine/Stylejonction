Stylejonction.Views.Backgrounds ||= {}

class Stylejonction.Views.Backgrounds.EditPatternView extends Backbone.View
  events:
    "change #portfolio_pattern_background_attributes_color"    : "updatePatternBackgroundColor"
    "click .pattern_link" : "updatePatternBackgroundImage"
    "click #pattern_btn" : "showPatternDialog"
    
  initialize: ()->
    init_colorpicker('#background_pattern_color_picker', '#portfolio_pattern_background_attributes_color')
    
    #intializa pattern dialog
    $.fx.speeds._default = 1000;
    $("#pattern_dialog").dialog({minWidth: 400, autoOpen: false})
    
   
    @portfolio = @options.portfolio
    @background = @options.model
    
    @.validatesParams()
    
 
  showPatternDialog: (e)->
    if $("#pattern_dialog").dialog('isOpen')
      $("#pattern_dialog").dialog('close')
    else
      $("#pattern_dialog").dialog('open')
      currentTarget = $(e.currentTarget)
      offset = currentTarget.offset()
      btn_height = currentTarget.height()
      btn_width =  currentTarget.width()
      offset.left += btn_width + 10
      offset.top -= $(".ui-dialog").height()/2 - btn_height /2
      $(".ui-dialog").offset(offset)
  
    
  updatePatternBackgroundColor: (e)->
    e.preventDefault()
    e.stopPropagation()
    
    target = $(e.currentTarget)
    newColor = target.val()
    
    @.$("#pattern_preview").css("background-color", "##{newColor}" )
    @.$("#final_preview").css("background-color",   "##{newColor}" )
    
   
    
    @background.set({ 'color': newColor })
    @portfolio.trigger 'backgroundChanged', @background
    
  updatePatternBackgroundImage: (e)->
    e.preventDefault()
    e.stopPropagation()
    
    target = $(e.currentTarget)
    pattern_id = target.data('id')
    pattern_url = target.data('url')
    
    $("#portfolio_pattern_background_attributes_pattern_id").val(pattern_id)
    
    @background.pattern.set({ id: pattern_id, pattern: {url: pattern_url} })
    @.$("#update_pattern_background .pattern").css("background-image", "url(#{pattern_url})" )
    @.$("#final_preview").css("background-image",  "url(#{pattern_url})" )
    
    @portfolio.trigger 'backgroundChanged', @background
    
    
    
    
  
      
    
    
  validatesParams: () ->
    if @portfolio not instanceof Stylejonction.Models.Portfolio
      debug.error 'Error. Portfolio object of EditPatternView is not valid'
      
    if @background not instanceof Stylejonction.Models.PatternBackground
      debug.error "Error. Background object of EditPatternView should PatternBackground #{this.background}"
     
    
    
  
    
    