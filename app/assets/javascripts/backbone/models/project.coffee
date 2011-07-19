class Stylejonction.Models.Project extends  Stylejonction.Models.Base
  paramRoot: 'project'
  url: '/portfolio/projects/:id'
  defaults:
    title: "New project"

  initialize: (options)->
    super
    @cover = new Stylejonction.Models.Image(options.cover)
    @cover.parent = this
    @ignored_attributes = ['cover']

class Stylejonction.Collections.ProjectsCollection extends Backbone.Collection
  model: Stylejonction.Models.Project
  url: '/portfolio/:portfolio_id/projects'


