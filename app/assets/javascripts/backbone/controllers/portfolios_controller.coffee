class Stylejonction.Controllers.PortfoliosController extends Backbone.Controller
  initialize: (options) ->
     @portfolio = new Stylejonction.Models.Portfolio(options.portfolio)
    
     #@portfolios = new Stylejonction.Collections.PortfoliosCollection()
     #@portfolios.refresh options.portfolios

  routes:
    ".*": "edit"


    
  edit:  ->
    @view = new Stylejonction.Views.Portfolios.EditView(model: @portfolio)
    $("#portfolio").html(@view.render().el)
    
    @view = new Stylejonction.Views.Portfolios.PreviewView(model: @portfolio)
    $("#preview").html(@view.render().el)
    
  