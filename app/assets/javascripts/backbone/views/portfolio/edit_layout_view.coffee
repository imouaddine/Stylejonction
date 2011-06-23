Stylejonction.Views.Portfolios ||= {}

class Stylejonction.Views.Portfolios.EditLayoutView extends Backbone.View
  template: JST["backbone/templates/portfolios/edit_layout"]
  
  events:
    "change #layout": "update"
    "change #theme": "update"
    
  update: (e) ->
    e.preventDefault()
    e.stopPropagation()
    
    @options.model.save()
    
 
    
  render: ->
    $(this.el).html(this.template(@options.model.toJSON() ))
    this.$("form").backboneLink(@options.model)
    return this