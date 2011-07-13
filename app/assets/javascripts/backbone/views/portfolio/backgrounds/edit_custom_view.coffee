Stylejonction.Views.Backgrounds ||= {}

class Stylejonction.Views.Backgrounds.EditCustomView extends Backbone.View
  events:
    "change input[name='display_mode']"    : "updateBgDisplayMode"
    
  
  initialize: ()->
    @portfolio = @options.portfolio
    @background =  @options.model
    
    #fancybox
    @.init_fancybox()
    #@.init_jcrop()






  init_jcrop: ()->
    $('.cropbox').Jcrop
       aspectRatio: 0
    
  init_fancybox: ()->
    $(".iframe_fancy").fancybox
      hideOnContentClick: false,
      showCloseButton: true,
      padding: 0
      
  updateBgDisplayMode: (e)->
    
    e.preventDefault()
    e.stopPropagation()
    portfolio = @portfolio
    target = $(e.currentTarget)
    @background.save(
       {'display_mode': target.val() },
       success: (model)->
         portfolio.trigger("backgroundChanged", model)
    )
    
   