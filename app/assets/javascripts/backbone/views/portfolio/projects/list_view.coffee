Stylejonction.Views.Projects ||= {}

class Stylejonction.Views.Projects.ProjectListView extends Backbone.View
  template: JST["backbone/templates/portfolios/projects/list"]
  
  events:
    "click .destroy" : "destroy"
      
  tagName: "li"
  
  destroy: () ->
    @options.model.destroy()
    this.remove()
    
    return false
    
  render: ->
    $(this.el).html(this.template(this.options.model.toJSON() ))    
    return this