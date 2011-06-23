class Stylejonction.Models.Project extends Backbone.Model
  paramRoot: 'project'
  defaults:
    title: "New project"
  
class Stylejonction.Collections.ProjectsCollection extends Backbone.Collection
  model: Stylejonction.Models.Project
  url: '/projects'