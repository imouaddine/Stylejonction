Stylejonction.Views.Portfolios ||= {}

class Stylejonction.Views.Portfolios.PreviewView extends Backbone.View
  template: JST["backbone/templates/portfolios/preview"]
    
  initialize: () ->
    @options.model.bind('change', this.update);
    @model = @options.model
   
  update: ->
    view = new Stylejonction.Views.Portfolios.PreviewView(model: this)
    $("#preview").html(view.render().el)
    
  render: ->
    $(this.el).html(this.template(@model.toJSON()))
    return this