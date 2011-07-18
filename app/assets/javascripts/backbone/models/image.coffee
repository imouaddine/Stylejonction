class Stylejonction.Models.Image extends Stylejonction.Models.Base
  paramRoot: 'image'
  url: '/images/'
  
  initialize: ()->
    super
    @parent = null
    
   