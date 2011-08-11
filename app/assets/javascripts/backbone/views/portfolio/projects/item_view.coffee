class Stylejonction.Views.Projects.PreviewProjectItemView extends Backbone.View
  template: JST["backbone/templates/portfolios/projects/item"]
  tagName:  "li",



  initialize: ->
    @project = @options.project
    _.bindAll(this, 'render', 'coverChanged')
    @project.bind('change', @.render)
    @project.cover.bind 'change', @.coverChanged
    @project.bind 'change:cover', @.coverChanged
    @project.bind('all', @.render)

  coverChanged: (changedCover)->
    @project.cover = changedCover
    $('img', this.el).attr('src', changedCover.get('image').display.url)
    
  render: ()->
    $(this.el).html(this.template(@project.toJSON(true)))
    return this

  remove: ->
    $(this.el).remove()



