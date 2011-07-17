class Stylejonction.Models.Project extends  Stylejonction.Models.Base
  paramRoot: 'project'
  url: '/portfolio/projects/:id'
  defaults:
    title: "New project"

  initialize: (options)->
    super
    @.url = @.url.replace ':id', @.id
    @cover = new Stylejonction.Models.Image(options.cover)
    @ignored_attributes = ['cover']

class Stylejonction.Collections.ProjectsCollection extends Backbone.Collection
  model: Stylejonction.Models.Project
  url: '/portfolio/:portfolio_id/projects'


