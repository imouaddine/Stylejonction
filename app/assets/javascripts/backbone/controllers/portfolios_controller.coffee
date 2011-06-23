class Stylejonction.Controllers.PortfoliosController extends Backbone.Controller
  initialize: (options) ->
    @portfolios = new Stylejonction.Collections.PortfoliosCollection()
    @portfolios.refresh options.portfolios

  routes:
    "/show": "show"
    "/edit": "edit"


 

  show:  ->
    portfolio = @portfolios.get(id)
    
    @view = new Stylejonction.Views.Portfolios.ShowView(model: portfolio)
    $("#portfolios").html(@view.render().el)
    
  edit: (id) ->
    portfolio = @portfolios.get(id)

    @view = new Stylejonction.Views.Portfolios.EditView(model: portfolio)
    $("#portfolios").html(@view.render().el)
  