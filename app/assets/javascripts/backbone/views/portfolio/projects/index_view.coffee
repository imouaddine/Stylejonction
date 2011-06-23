Stylejonction.Views.Projects ||= {}

class Stylejonction.Views.Projects.IndexView extends Backbone.View
  template: JST["backbone/templates/projects/index"]
    
  initialize: () ->
    _.bindAll(this, 'addOne', 'addAll', 'render');
    
    @options.projects.bind('refresh', this.addAll);
   
  addAll: () ->
    @options.projects.each(this.addOne)
  
  addOne: (project) ->
    view = new Stylejonction.Views.Projects.ProjectView({model : project})
    this.$("tbody").append(view.render().el)
       
  render: ->
    $(this.el).html(this.template(projects: this.options.projects.toJSON() ))
    @addAll()
    
    return this