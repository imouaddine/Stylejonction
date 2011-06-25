Stylejonction.Views.Portfolios ||= {}

class Stylejonction.Views.Portfolios.PreviewView extends Backbone.View
  template: JST["backbone/templates/portfolios/preview"]
  
 

  
  initialize: ()->
    _.bindAll(this, 'addOneProject', 'addAllProjects', 'render', 'update')
    @portfolio = @options.portfolio
    @projects = @options.projects
    
    @options.portfolio.bind('change',     this.update)
    @options.projects.bind('add',     this.addOneProject)
    
  addOneProject: (project) ->
    @view = new Stylejonction.Views.Projects.PreviewProjectItemView({project: project})
    @.$("#projects-list").after(@view.render().el)
  
  addAllProjects: ->
    @projects.each(this.addOneProject);
  
  update: ->
    $('#theme').text(@portfolio.get('theme'))
  
  render: ->
    $(this.el).html(this.template(@options.portfolio.toJSON()))
    @addAllProjects()
    return this