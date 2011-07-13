Stylejonction.Views.Projects ||= {}

class Stylejonction.Views.Projects.EditView extends Backbone.View

  events:
    "change #title": "update"
    "change #project_default": "update"

  initialize: ()->
    @project = @options.model

  update: (e) ->
    e.preventDefault()
    e.stopPropagation()

    title = $("#title").val()
    default_project = $("#project_default").is(":checked")
    @options.model.save({'title' : title, 'default' : default_project},
      success: ->
        #console.log "SAVED"
      error: ->
        #console.log 'ERROR'
    )

