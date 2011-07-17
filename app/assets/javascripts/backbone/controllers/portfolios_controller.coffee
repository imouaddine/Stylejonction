class Stylejonction.Controllers.PortfoliosController extends Backbone.Controller

  initialize: (options) ->
    @options = options
    @portfolio = new Stylejonction.Models.Portfolio(options.portfolio)
    @projects = new Stylejonction.Collections.ProjectsCollection()
    @projects.url = @projects.url.replace ':portfolio_id', @portfolio.id
    @background = new Stylejonction.Models.BackgroundFactory().create( @portfolio.get('background_type'), options.background )
    @body_font = new Stylejonction.Models.Font(options.body_font)
    @title_font = new Stylejonction.Models.Font(options.title_font)

    @projects.refresh options.projects
    @action = "this." + options.action+'()'

  routes:
    ".*": "default"
    "projects/:i/edit" : "edit_project"

  default: ->
    eval(@action)
    @add_preview()

  edit_layout_portfolio: ->
    @view = new Stylejonction.Views.Portfolios.EditLayoutView(model: @portfolio, el: '#edit_portfolio_layout')

  edit_font_portfolio: ->

    @view = new Stylejonction.Views.Portfolios.EditFontView(model: @portfolio, body_font: @body_font, title_font: @title_font, el: '#edit_portfolio_font')

  edit_project: ->
    @project = @projects.get(@options.project.id)
    @cover = new Stylejonction.Models.Image(@.options.cover)
    @view = new Stylejonction.Views.Projects.EditView(model: @project, cover: @cover, el: '#edit_project_properties')

  add_preview: ->
    @previewView = new Stylejonction.Views.Portfolios.PreviewView(
      projects: @projects,
      portfolio: @portfolio,
      background: @background,
      body_font: @body_font,
      title_font: @title_font
    )
    $("#preview").html(@previewView.render().el)








