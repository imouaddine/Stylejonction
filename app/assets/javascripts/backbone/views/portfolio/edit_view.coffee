Stylejonction.Views.Portfolios ||= {}

class Stylejonction.Views.Portfolios.EditLayoutView extends Backbone.View 

  
  events:
    "change #portfolio_theme": "updateTheme"
  

     
  updateTheme: (e) ->
    console.log $("#portfolio_theme").val()
    
    
    e.preventDefault()
    e.stopPropagation()
    
    @options.model.save(
      {'theme': $("#portfolio_theme").val()},
    )
    
