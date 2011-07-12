class Stylejonction.Models.Project extends Backbone.Model
  paramRoot: 'project'
  url: '/portfolio/projects/:id'
  defaults:
    title: "New project"

  initialize: ()->
    @.url = @.url.replace ':id', @.id

class Stylejonction.Collections.ProjectsCollection extends Backbone.Collection
  model: Stylejonction.Models.Project
  url: '/portfolio/:portfolio_id/projects'


