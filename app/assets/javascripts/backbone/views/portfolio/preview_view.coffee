Stylejonction.Views.Portfolios ||= {}

class Stylejonction.Views.Portfolios.PreviewView extends Backbone.View
  template: JST["backbone/templates/portfolios/preview"]


  initialize: ()->
    _.bindAll(this, 'addOneProject', 'addAllProjects', 'render', 'update', 'updateBackground', 'updateBodyFont', 'updateTitleFont')
    @portfolio = @options.portfolio
    @projects = @options.projects
    
  
    
    @portfolio.bind 'change', @.update
    @projects.bind  'add',     @.addOneProject
    @portfolio.bind 'backgroundChanged', @.updateBackground
    @portfolio.body_font.bind 'change', @.updateBodyFont
    @portfolio.title_font.bind 'change', @.updateTitleFont

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
    

    if @portfolio.hasChanged('body_font_id')
      @portfolio.body_font = new Stylejonction.Models.Font({id: @portfolio.get('body_font_id')}) 
      @portfolio.body_font.bind 'change', @.updateBodyFont
      @portfolio.body_font.fetch()
      
    if @portfolio.hasChanged('title_font_id')
      @portfolio.title_font = new Stylejonction.Models.Font({id: @portfolio.get('title_font_id')}) 
      @portfolio.title_font.bind 'change', @.updateTitleFont
      @portfolio.title_font.fetch()
     
    
    

  updateBackground: (background)->
    @portfolio.background = background
    @portfolio.background.render($("#preview"))
    
  updateBodyFont: (font)->
    @.$("#preview_content .content").css("fontFamily", font.get('name'))
    @.addFontUrl(font)
     
    
  updateTitleFont: (font) ->
    @.$("#preview_content .title").css("fontFamily", font.get('name'))
    @.addFontUrl(font)
    
        
    
  addFontUrl: (font) ->
    if font.has('url')
      font_url = font.get('url')
      if $("link[href='#{font_url}']").length == 0
        $('head').append("<link  href='#{font_url}' type='text/css' />");
      
    
  render: ->
    $(this.el).html(this.template(@options.portfolio.toJSON()))
    @portfolio.background.render( $("#preview") )
    @addAllProjects()
    @.update()
    @.updateBodyFont(@portfolio.body_font)
    @.updateTitleFont(@portfolio.title_font)
    return this


