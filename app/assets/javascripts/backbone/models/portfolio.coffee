class Stylejonction.Models.Portfolio extends Backbone.Model
  paramRoot: 'portfolio'
  url: '/portfolio/update'
  
  defaults:
    layout: null
    theme: null
  
class Stylejonction.Collections.PortfoliosCollection extends Backbone.Collection
  model: Stylejonction.Models.Portfolio
  url: '/portfolio'