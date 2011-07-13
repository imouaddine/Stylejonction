Stylejonction.Views.Backgrounds ||= {}

class Stylejonction.Views.Backgrounds.EditPredefinedView extends Backbone.View
  events:
    "click .image_link"     : "updatePredefinedBackground"
    
  initialize: ()->
   @.init_jcarousel()
   @.validatesParams();
   
    
    
  init_jcarousel: () ->
    start_position = @.$("#background_carousel li.selected").index()
    @.$("#background_carousel").jcarousel
      scroll :1,
      initCallback: @.on_init_carousel,
      buttonNextHTML: null,
      buttonPrevHTML: null
      start: start_position
  
  on_init_carousel: (carousel) ->
    $('#left_scroll_bg').bind 'click', () =>
      carousel.prev()
      false

    $('#right_scroll_bg').bind 'click', () => 
      carousel.next()
      false;  
      
    
  updatePredefinedBackground: (e)->
    e.preventDefault()
    e.stopPropagation()
    target = $(e.currentTarget)
    newBackground = target.data('id')
    @.$(".image_link").removeClass("selected")
    @.$("li").removeClass("selected")
    
    @options.model.save({'background_id': newBackground, 'predefined_background_id':  newBackground, 'background_type': 'PredefinedBackground'}, 
      success: (model) -> 
        $(e.currentTarget).parent().addClass("selected")
        $(e.currentTarget).addClass("selected")
        background = new Stylejonction.Models.CustomBackground({id:model.get('background_id')})
        background.fetch(
          success: ->
            model.trigger("backgroundChanged", background)
        )
        
      error: ->
        alert 'Something wrong happened'
    )
  
  validatesParams: ()->
    if @options.model not instanceof Stylejonction.Models.Portfolio
      debug.error 'Error. Portfolio object of PredefinedView is not valid'
   
   
    
    
    
