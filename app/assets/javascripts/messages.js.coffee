class Stylejonction.Messages
  constructor: ()->
    @.types = ['notice','warning','error']
    $('.message').click ->
      $(this).animate({top: -$(this).outerHeight()}, 500)

  hideAll: ()->
    messageHeights = new Array()
    for type in @.types
      type_element = $(".#{type}")
      height = type_element.outerHeight()
      messageHeights.push(height)
      type_element.css('top', -height)

  show: (type, message)->
    @.hideAll()
    if message isnt ''
      $(".#{type}").html(message)
    $(".#{type}").animate({top: "0"}, 500)





