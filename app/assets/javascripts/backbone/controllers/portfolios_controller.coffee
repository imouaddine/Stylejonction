class Stylejonction.Controllers.PortfoliosController extends Backbone.Controller
  initialize: (options) ->
    @options = options
    @portfolio = new Stylejonction.Models.Portfolio(options.portfolio)
    @projects = new Stylejonction.Collections.ProjectsCollection()
    @projects.refresh options.projects
    @action = "this." + options.action+'()'
    
     
  routes:
    ".*": "default"
    "font": "edit_font"
    "projects/:id/edit" : "edit_project"

  default: ->
    console.log @action
    eval(@action) 
    @add_preview()
  
  edit_portfolio: ->
    @view = new Stylejonction.Views.Portfolios.EditView(model: @portfolio, el: '#edit_portfolio_3')
    
  
  edit_project: ->
    @project = @projects.get(@options.project.id)
    @view = new Stylejonction.Views.Projects.EditView(model: @project, el: '#main')

    
    
    


  
    
  edit_font: ->
    @view = new Stylejonction.Views.Portfolios.EditFontView(model: @portfolio)
    $("#stage").html(@view.render().el)
   
    
 
    
    
    
  add_preview: ->
    @view = new Stylejonction.Views.Portfolios.PreviewView(projects: @projects, portfolio: @portfolio)
    $("#preview").html(@view.render().el)
    
    
    
      

    
  