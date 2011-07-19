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
    newBackgroundId = target.data('id')
    @.$(".image_link").removeClass("selected")
    @.$("li").removeClass("selected")
    
    portfolio = @options.model
    background = new Stylejonction.Models.PredefinedBackground( { id: newBackgroundId } )
   
    $(e.currentTarget).parent().addClass("selected")
    $(e.currentTarget).addClass("selected")
    $("#portfolio_background_id").val(newBackgroundId)
    $("#portfolio_background_type").val("PredefinedBackground")
    $("#portfolio_predefined_background_id").val(newBackgroundId)
    
    background.fetch(
      success: (newBackground) ->
        portfolio.trigger("backgroundChanged", newBackground)
    )
    
  validatesParams: ()->
    if @options.model not instanceof Stylejonction.Models.Portfolio
      debug.error 'Error. Portfolio object of PredefinedView is not valid'
   
   
    
    
    
