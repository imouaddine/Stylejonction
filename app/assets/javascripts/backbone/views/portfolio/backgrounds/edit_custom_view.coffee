Stylejonction.Views.Backgrounds ||= {}

class Stylejonction.Views.Backgrounds.EditCustomView extends Backbone.View
  
  events:
    "click #save_btn"      : "save"
    "click #cancel_btn"    : "cancel"
    
  
  initialize: ()->
    @portfolio = @options.portfolio
    @background =  @options.model
    
    @.validatesParams()
   
    #fancybox
    @.init_fancybox()
   

    
  init_fancybox: ()->
    $(".iframe_fancy").fancybox
      hideOnContentClick: false,
      showCloseButton: true,
      padding: 0
      
  save: (e)->
    e.preventDefault()
    e.stopPropagation()
    portfolio = @portfolio
    
    
    newDisplayMode = @.$("#edit_background input[type='radio']:checked").val()
    console.log(newDisplayMode);
    
    @portfolio.custom_background.save(
       {'display_mode': newDisplayMode },
       success: (model)->
         portfolio.trigger("backgroundChanged", model)
    )
   
    $.fancybox.close()
    
  cancel: (e)->
    e.preventDefault()
    e.stopPropagation()
    $.fancybox.close()
    
  validatesParams: ()->
    if @portfolio not instanceof Stylejonction.Models.Portfolio
      debug.error 'Error. Portfolio object of EditCustomView is not valid'
      
    if @background not instanceof Stylejonction.Models.CustomBackground
      debug.error 'Error. Background object of EditCustomView should CustomBackground'
    
    
   