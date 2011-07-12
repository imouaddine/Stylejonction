Stylejonction.Views.Portfolios ||= {}

class Stylejonction.Views.Portfolios.PreviewView extends Backbone.View
  template: JST["backbone/templates/portfolios/preview"]


  initialize: ()->
    _.bindAll(this, 'addOneProject', 'addAllProjects', 'render', 'update', 'updateBackground')
    @portfolio = @options.portfolio
    @projects = @options.projects
    @background = @options.background
    


    @options.portfolio.bind 'change', @.update
    @options.projects.bind  'add',     @.addOneProject
    @options.portfolio.bind 'backgroundChanged', @.updateBackground
   

  addOneProject: (project) ->
    @view = new Stylejonction.Views.Projects.PreviewProjectItemView({project: project})
    @.$("#projects_list").after(@view.render().el)

  addAllProjects: ->
    @projects.each(this.addOneProject);

  update: ->
    layout = @options.portfolio.get('layout')
    $("#preview").addClass("layout-#{layout}");
    
    theme = @options.portfolio.get('theme')
    $("#preview").addClass("theme-#{theme}");
    

  updateBackground: (background)->
    @background = background
    @background.render($("#preview"))
    
  render: ->
    $(this.el).html(this.template(@options.portfolio.toJSON()))
    @background.render( $("#preview") )
    @addAllProjects()
    @.update()
    return this


