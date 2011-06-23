Stylejonction.Views.Portfolios ||= {}

class Stylejonction.Views.Portfolios.EditFontView extends Backbone.View
  template: JST["backbone/templates/portfolios/edit_font"]
  
  events:
    "submit #edit-portfolio": "update"
    
  update: (e) ->
    e.preventDefault()
    e.stopPropagation()
    
    @options.model.save(null,
      success:(model) =>
        @options.model = model
        window.location.hash = "/#edit_font"
    )
    
  render: ->
    $(this.el).html(this.template(@options.model.toJSON() ))
    this.$("form").backboneLink(@options.model)
    return this