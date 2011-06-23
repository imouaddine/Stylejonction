class Stylejonction.Views.Projects.PreviewProjectItemView extends Backbone.View
  template: JST["backbone/templates/portfolios/projects/item"]
  tagName:  "li",
  
  
  initialize: () ->
    _.bindAll(this, 'render');
    @options.project.bind('change', this.render);

  render: ->
    $(this.el).html(this.template(@options.project.toJSON()))
    return this
  
  remove: ->
    $(this.el).remove()
  
  
      