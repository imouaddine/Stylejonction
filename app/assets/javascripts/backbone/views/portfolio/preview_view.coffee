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
    @.$("#projects_list").append(@view.render().el)

  addAllProjects: ->
    @projects.each(this.addOneProject);

  update: ->
    if @portfolio.hasChanged('layout')
      layout = @portfolio.get('layout')
      $("#preview_content").removeClass(className) for className in ['layout_left', 'layout_right', 'layout_top', 'layout_bottom']
      $("#preview_content").addClass("layout_#{layout}");
    
    if @portfolio.hasChanged('theme')
      $("#preview_content").removeClass(className) for className in ['theme_light', 'theme_dark']
      theme = @portfolio.get('theme')
      $("#preview_content").addClass("theme_#{theme}");
    

  updateBackground: (background)->
    @background = background
    @background.render($("#preview"))
    
  render: ->
    $(this.el).html(this.template(@options.portfolio.toJSON()))
    @background.render( $("#preview") )
    @addAllProjects()
    @.update()
    return this


