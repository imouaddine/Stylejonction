Stylejonction.Views.Projects ||= {}

class Stylejonction.Views.Projects.EditView extends Backbone.View

  events:
    "change #title": "update"
    "change #project_default": "update"
    "click #public_project_btn": "update_visibility_public"
    "click #private_project_btn": "update_visibility_private"

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

  update_visibility_public: (e) ->
    e.preventDefault()
    e.stopPropagation()
    @.$("#private_project_btn").removeClass("selected")
    @options.model.save({'public' : true},
        success: ->
          @.$("#public_project_btn").addClass("selected")
        error: ->
    )

  update_visibility_private: (e) ->
    e.preventDefault()
    e.stopPropagation()
    @.$("#public_project_btn").removeClass("selected")
    @options.model.save({'public' : false},
        success: ->
          @.$("#private_project_btn").addClass("selected")
        error: ->
    )

