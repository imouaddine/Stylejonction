Stylejonction.Views.Portfolios ||= {}

class Stylejonction.Views.Portfolios.PreviewView extends Backbone.View
  template: JST["backbone/templates/portfolios/preview"]
  

  
  initialize: ()->
    _.bindAll(this, 'addOneProject', 'addAllProjects', 'render')
    
    @projects = @options.projects
    
    @options.projects.bind('add',     this.addOneProject)
    #@options.projects.bind('refresh', this.addAllProjects)
    #@options.projects.bind('all',     this.render)
    
   
    
  addOneProject: (project) ->
    view = new Stylejonction.Views.Projects.PreviewProjectItemView({project: project})
    this.$("#projects-list").after(view.render().el)
   
  
  addAllProjects: ->
    @projects.each(this.addOneProject);
  
  render: ->
    $(this.el).html(this.template(@options.portfolio.toJSON()))
    @addAllProjects()
    return this