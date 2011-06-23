Stylejonction.Views.Portfolios ||= {}

class Stylejonction.Views.Portfolios.ShowView extends Backbone.View
  template: JST["backbone/templates/portfolios/show"]
   
  render: ->
    $(this.el).html(this.template(this.options.model.toJSON() ))
    return this