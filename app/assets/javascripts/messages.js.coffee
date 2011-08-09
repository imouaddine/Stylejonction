class Stylejonction.Messages
  constructor: ()->
    @.types = ['notice','warning','error']
    $('div.message').click ->
      $(this).animate({top: -$(this).outerHeight()}, 1000)

  hideAll: ()->
    messageHeights = new Array()
    for type in @.types
      type_element = $("div.#{type}")
      height = type_element.outerHeight()
      messageHeights.push(height)
      type_element.css('top', -height)

  show: (type, message)->
    @.hideAll()
    if message isnt ''
      $("div.#{type}").html(message)
    $("div.#{type}").animate({top: "0"}, 1000)
    setTimeout =>
         @hideAll()
        , 5000
        
       
    
    





