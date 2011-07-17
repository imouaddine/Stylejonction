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

  edit_layout_portfolio: ->
  
    @view = new Stylejonction.Views.Portfolios.EditLayoutView(
      model: @portfolio
      el: '#edit_portfolio_layout'
    )

  edit_font_portfolio: ->
    
    @view = new Stylejonction.Views.Portfolios.EditFontView(model: @portfolio, el: '#edit_portfolio_font')

  edit_project: ->
    @project = @projects.get(@options.project.id)
    @view = new Stylejonction.Views.Projects.EditView(model: @project, el: '#edit_project_properties')

  add_preview: ->
    @previewView = new Stylejonction.Views.Portfolios.PreviewView(
      projects: @projects,
      portfolio: @portfolio
    )
    $("#preview").html(@previewView.render().el)








