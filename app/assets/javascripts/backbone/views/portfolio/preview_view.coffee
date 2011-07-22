Stylejonction.Views.Portfolios ||= {}

class Stylejonction.Views.Portfolios.PreviewView extends Backbone.View
  template: JST["backbone/templates/portfolios/preview"]


  initialize: ()->
    _.bindAll(this, 'addOneProject', 'addAllProjects', 'render', 'update', 'updateBackground', 'updateBodyFont', 'updateTitleFont')

    @portfolio = @options.portfolio
    @projects = @options.projects

    @body_font = @portfolio.body_font
    @title_font = @portfolio.body_font
    @background = @portfolio.background

    @portfolio.bind 'change', @.update
    @projects.bind  'add',     @.addOneProject
    @portfolio.bind 'backgroundChanged', @.updateBackground

  addOneProject: (project) ->
    @view = new Stylejonction.Views.Projects.PreviewProjectItemView({project: project})
    @.$("#projects_list").append(@view.render().el)

  addAllProjects: ->
    @projects.each(this.addOneProject);

  update: ->
    if @portfolio.hasChanged('layout')
      layout = @portfolio.get('layout')
      $("#preview_content").removeClass(className) for className in ['layout_left', 'layout_right', 'layout_top', 'layout_bottom']
      $("#preview_content").addClass("layout_#{layout}")

    if @portfolio.hasChanged('theme')
      $("#preview_content").removeClass(className) for className in ['theme_light', 'theme_dark']
      theme = @portfolio.get('theme')
      $("#preview_content").addClass("theme_#{theme}")

    if @portfolio.hasChanged('body_font_id')
      @portfolio.body_font = new Stylejonction.Models.Font({id: @portfolio.get('body_font_id')})
      @portfolio.body_font.bind 'change', @.updateBodyFont
      @portfolio.body_font.fetch()

    if @portfolio.hasChanged('title_font_id')
      @title_font = new Stylejonction.Models.Font({id: @portfolio.get('title_font_id')})
      @title_font.bind 'change', @.updateTitleFont
      @title_font.fetch()

    if @portfolio.hasChanged('title_color')
      @.updateTitleColor(@portfolio.get('title_color') )

    if @portfolio.hasChanged('body_color')
      @.updateBodyColor(@portfolio.get('body_color') )



  #triggered when background changed
  updateBackground: (background)->
    console.log background
    @background = background
    @background.render($("#preview"))

  updateBodyFont: (font)->
    @.$("#preview_content .content").css("fontFamily", font.get('name'))
    @.addFontUrl(font)


  updateTitleFont: (font) ->
    @.$("#preview_content .title").css("fontFamily", font.get('name'))
    @.addFontUrl(font)

  updateTitleColor: (title_color) ->
    @.$("#preview_content .title").css("color", "##{title_color}")

  updateBodyColor: (body_color) ->
    @.$("#preview_content .content").css("color", "##{body_color}")

  addFontUrl: (font) ->
    if font.has('url')
      font_url = font.get('url')
      if $("link[href='#{font_url}']").length == 0
        $('head').append("<link  href='#{font_url}' type='text/css' />");


  render: ->
    $(this.el).html(this.template(@options.portfolio.toJSON()))
    # This causes a js render error, I have no idea why
    @background.render($("#preview"))
    @addAllProjects()
    @.update()
    @.updateBodyFont(@body_font)
    @.updateTitleFont(@title_font)
    @.updateTitleColor(@portfolio.get('title_color') )
    @.updateBodyColor(@portfolio.get('body_color') )
    return this


