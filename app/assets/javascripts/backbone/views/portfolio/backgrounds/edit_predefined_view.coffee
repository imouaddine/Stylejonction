Stylejonction.Views.Backgrounds ||= {}

class Stylejonction.Views.Backgrounds.EditPredefinedView extends Backbone.View
  events:
    "click .image_link"     : "updatePredefinedBackground"

  initialize: ()->
    #Get selected background
    start_position = @.$("#background_carousel li.selected").index()
    @.$("#background_carousel").jcarousel
      scroll :1,
      initCallback: @.init_carousel,
      buttonNextHTML: null,
      buttonPrevHTML: null
      start: start_position


  #background carousel
  init_carousel: (carousel) ->
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
    console.log newBackground
    @.$(".image_link").removeClass("selected")
    @.$("li").removeClass("selected")

    @options.model.save({'background_id': newBackground, 'background_type': 'PredefinedBackground'},
      success: ->
        #target.children(".select_loading_overlay").hide();
        $(e.currentTarget).parent().addClass("selected")
        $(e.currentTarget).addClass("selected")
      error: ->
        alert 'Something wrong happened'
    )
