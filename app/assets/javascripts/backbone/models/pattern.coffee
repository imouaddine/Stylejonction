class Stylejonction.Models.Pattern extends  Stylejonction.Models.Base
  paramRoot: 'pattern'
  url: '/patterns/:id'


  initialize: (options)->
    super
    @image = new Stylejonction.Models.Image(options.image)
