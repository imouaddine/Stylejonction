Stylejonction.Views.Projects ||= {}

class Stylejonction.Views.Projects.EditView extends Backbone.View
  
  events:
    "change #project_title": "update"
    
  update: (e) ->
    title = $("#project_title").val()
    
    e.preventDefault()
    e.stopPropagation()
    
    @options.model.save(
      {'title' : title},
      success: ->
        #console.log "SAVED"
      error: ->
        #console.log 'ERROR'
    )
    
