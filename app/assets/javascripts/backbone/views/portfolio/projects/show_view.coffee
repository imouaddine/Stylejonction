Stylejonction.Views.Projects ||= {}

class Stylejonction.Views.Projects.ShowView extends Backbone.View
  template: JST["backbone/templates/portfolio/projects/show"]
   
  render: ->
    $(this.el).html(this.template(this.options.model.toJSON() ))
    return this