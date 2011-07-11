Stylejonction.Views.Portfolios ||= {}

class Stylejonction.Views.Portfolios.PreviewView extends Backbone.View
  template: JST["backbone/templates/portfolios/preview"]
  
  
  initialize: ()->
    _.bindAll(this, 'addOneProject', 'addAllProjects', 'render', 'update')
    @portfolio = @options.portfolio
    @projects = @options.projects
    @background = @options.background
    
    @options.portfolio.bind('change',     this.update)
    @options.projects.bind('add',     this.addOneProject)
    
  addOneProject: (project) ->
    @view = new Stylejonction.Views.Projects.PreviewProjectItemView({project: project})
    @.$("#projects-list").after(@view.render().el)
  
  addAllProjects: ->
    @projects.each(this.addOneProject);
  
  update: ->
    console.log 'UPDATE'
    @background.fetch(
      success: (model)->
        model.render($("#preview"))
    )
    $('#theme').text(@portfolio.get('theme'))
  
  render: ->
    $(this.el).html(this.template(@options.portfolio.toJSON()))
    @background.render($("#preview"))
    @addAllProjects()
    return this
    
    
    