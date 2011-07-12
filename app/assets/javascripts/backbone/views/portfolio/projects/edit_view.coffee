Stylejonction.Views.Projects ||= {}

class Stylejonction.Views.Projects.EditView extends Backbone.View

  events:
    "change #title": "update"

  initialize: ()->
    @project = @options.model

  update: (e) ->
    title = $("#title").val()
    @options.model.save({'title' : title},
      success: ->
        #console.log "SAVED"
      error: ->
        #console.log 'ERROR'
    )

    # e.preventDefault()
    # e.stopPropagation()

    # @options.model.save(
    #   {'title' : title},
    #   success: ->
    #     #console.log "SAVED"
    #   error: ->
    #     #console.log 'ERROR'
    # )

