Stylejonction.Views.Backgrounds ||= {}

class Stylejonction.Views.Backgrounds.EditCustomView extends Backbone.View
  events:
    "change input[name='display_mode']"    : "updateBgDisplayMode"
    
  
  initialize: ()->
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
    target = $(e.currentTarget)
    @options.model.fetch(
      success: (e)->
        e.set({'display_mode': target.val() })
        e.save(
          success: (ee)->
            
        )
        
    )
