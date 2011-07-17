class Stylejonction.Views.Projects.PreviewProjectItemView extends Backbone.View
  template: JST["backbone/templates/portfolios/projects/item"]
  tagName:  "li",
  
  
  initialize: ->
    @project = @options.project
    _.bindAll(this, 'render');
    @project.bind('change', this.render);
    @project.bind('all', this.render);
    
    
  render: ->
    $(this.el).html(this.template(@project.toJSON()))
    
    
    return this
  
  remove: ->
    $(this.el).remove()
  
  
      