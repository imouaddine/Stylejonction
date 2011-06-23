Stylejonction.Views.Portfolios ||= {}

class Stylejonction.Views.Portfolios.IndexView extends Backbone.View
  template: JST["backbone/templates/portfolios/index"]
    
  initialize: () ->
    _.bindAll(this, 'addOne', 'addAll', 'render');
    
    @options.portfolios.bind('refresh', this.addAll);
   
  addAll: () ->
    @options.portfolios.each(this.addOne)
  
  addOne: (portfolio) ->
    view = new Stylejonction.Views.Portfolios.PortfolioView({model : portfolio})
    this.$("tbody").append(view.render().el)
       
  render: ->
    $(this.el).html(this.template(portfolios: this.options.portfolios.toJSON() ))
    @addAll()
    
    return this