class Stylejonction.Models.Font extends Stylejonction.Models.Base
  paramRoot: 'font'
  url: '/fonts/:id.json'
  
  initialize: ()->
    super
    @.url = @.url.replace ':id', @.id
  