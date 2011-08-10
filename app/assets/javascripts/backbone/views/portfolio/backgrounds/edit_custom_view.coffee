Stylejonction.Views.Backgrounds ||= {}

class Stylejonction.Views.Backgrounds.EditCustomView extends Backbone.View
  el: '#edit_background'
  events:
    "click #save_btn"      : "save"
    "click #cancel_btn"    : "cancel"
    "change input[type='radio']" : "preview"
    
  
  initialize: ()->
    @portfolio = @options.portfolio
    @background =  @options.model
    @.validatesParams()
    @old_display_mode = @background.get('display_mode')
  
  preview: (e)->
    newDisplayMode = @.$("input[type='radio']:checked").val()
    @portfolio.custom_background.set({'display_mode': newDisplayMode})
    @portfolio.trigger("backgroundChanged", @portfolio.custom_background)
    
  save: (e)->
    e.preventDefault()
    e.stopPropagation()
    portfolio = @portfolio
    
    
    newDisplayMode = @.$("input[type='radio']:checked").val()
   
    
    @portfolio.custom_background.save(
       {'display_mode': newDisplayMode },
       success: (model)->
         portfolio.trigger("backgroundChanged", model)
    )
   
    $.fancybox.close()
    
  cancel: (e)->
    e.preventDefault()
    e.stopPropagation()
    @portfolio.custom_background.set({'display_mode': @old_display_mode})
    console.log  @portfolio.custom_background
    @portfolio.trigger("backgroundChanged", @portfolio.custom_background)
    $.fancybox.close()
    
  validatesParams: ()->
    if @portfolio not instanceof Stylejonction.Models.Portfolio
      debug.error 'Error. Portfolio object of EditCustomView is not valid'
      
    if @background not instanceof Stylejonction.Models.CustomBackground
      debug.error 'Error. Background object of EditCustomView should CustomBackground'
    
    
   