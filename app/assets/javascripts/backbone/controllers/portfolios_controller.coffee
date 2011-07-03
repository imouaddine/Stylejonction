class Stylejonction.Controllers.PortfoliosController extends Backbone.Controller
  
  initialize: (options) ->
    @options = options
    @portfolio = new Stylejonction.Models.Portfolio(options.portfolio)
    @projects = new Stylejonction.Collections.ProjectsCollection()
    @projects.url = @projects.url.replace ':portfolio_id', @portfolio.id
    @projects.refresh options.projects
    @action = "this." + options.action+'()'
    
     
  routes:
    ".*": "default"
    "projects/:i/edit" : "edit_project"

  default: ->
    eval(@action) 
    @add_preview()
  
  edit_portfolio: ->
    @view = new Stylejonction.Views.Portfolios.EditView(model: @portfolio, el: '#edit')
    
  edit_project: ->
    @project = @projects.get(@options.project.id)
    @view = new Stylejonction.Views.Projects.EditView(model: @project, el: '#edit')
    
  new_project: ->
    
  add_preview: ->
    @view = new Stylejonction.Views.Portfolios.PreviewView(projects: @projects, portfolio: @portfolio)
    $("#preview").html(@view.render().el)
    
    
    
      

    
  