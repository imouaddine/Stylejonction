class Stylejonction.Controllers.PortfoliosController extends Backbone.Controller
  initialize: (options) ->
      @portfolio = new Stylejonction.Models.Portfolio(options.portfolio)
      @projects = new Stylejonction.Collections.ProjectsCollection()
      @projects.refresh options.projects
      
      
     
  routes:
    ".*": "edit_layout"
    "font": "edit_font"
    "projects/:id/edit" : "edit_project"

    
  edit_layout:  ->

    
    @view = new Stylejonction.Views.Portfolios.EditLayoutView(model: @portfolio)
    $("#stage").html(@view.render().el)
    @add_preview()
  
    
  edit_font: ->
    @view = new Stylejonction.Views.Portfolios.EditFontView(model: @portfolio)
    $("#stage").html(@view.render().el)
    @add_preview()
    
  edit_project: (id) ->
    project = @projects.get(id)
    @view = new Stylejonction.Views.Projects.EditView(model: project)
    $("#stage").html(@view.render().el)
    @add_preview()
    
    
  add_preview: ->
   
    @view = new Stylejonction.Views.Portfolios.PreviewView(projects: @projects, portfolio: @portfolio)
    $("#preview").html(@view.render().el)
    
    
    
      

    
  