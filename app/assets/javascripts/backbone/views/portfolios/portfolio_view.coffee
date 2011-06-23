Stylejonction.Views.Portfolios ||= {}

class Stylejonction.Views.Portfolios.PortfolioView extends Backbone.View
  template: JST["backbone/templates/portfolios/portfolio"]
  
  events:
    "click .destroy" : "destroy"
      
  tagName: "tr"
  
  destroy: () ->
    @options.model.destroy()
    this.remove()
    
    return false
    
  render: ->
    $(this.el).html(this.template(this.options.model.toJSON() ))    
    return this