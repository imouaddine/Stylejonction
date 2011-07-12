Stylejonction.Views.Projects ||= {}

class Stylejonction.Views.Projects.EditView extends Backbone.View

  events:
    "change #title": "update"

  render:
    console.log "What the fuck is going on"

  initialize: ()->
    console.log "here a m"
    @project = @options.model


  update: (e) ->
    console.log "wutufy"
    title = $("#title").val()

    # e.preventDefault()
    # e.stopPropagation()

    # @options.model.save(
    #   {'title' : title},
    #   success: ->
    #     #console.log "SAVED"
    #   error: ->
    #     #console.log 'ERROR'
    # )

