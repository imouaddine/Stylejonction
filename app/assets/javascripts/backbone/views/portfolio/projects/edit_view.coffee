Stylejonction.Views.Projects ||= {}

class Stylejonction.Views.Projects.EditView extends Backbone.View

  events:
    "change #title":                "update"
    "change #project_default":      "update"
    "click #public_project_btn":    "update_visibility_public"
    "click #private_project_btn":   "update_visibility_private"
    "click #send_invites":          "send_invites"
    

  initialize: ()->
    @project = @options.model
    @cover = @options.cover
    @.init_fancybox()
    
  init_fancybox: ()->
   
    $(".iframe_fancy").fancybox
      hideOnContentClick: false,
      showCloseButton: true,
      padding: 0,
      onComplete: @.on_fancybox_complete
      
  on_fancybox_complete: ()->
    edit_cover_view = new Stylejonction.Views.Projects.EditCoverView({el: "body", project: window.controller.project, cover: window.controller.cover})
    
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
  
    @.$("#public_project").show("medium")
    @.$("#private_project").hide("medium")
     
    @.$("#private_project_btn").removeClass("selected")
    @options.model.save({'public' : true},
        success: ->
          @.$("#public_project_btn").addClass("selected")
        error: ->
          debug.error 'An error has occurred while making the project public'
    )

  update_visibility_private: (e) ->
    e.preventDefault()
    e.stopPropagation()
  
    @.$("#private_project").show("medium")
    @.$("#public_project").hide("medium")
    
    @.$("#public_project_btn").removeClass("selected")
    @options.model.save({'public' : false},
       success: ->
         @.$("#private_project_btn").addClass("selected")
       error: ->
         debug.error 'An error has occurred while making the project private'
    )

  send_invites: (e)->
    e.preventDefault()
    e.stopPropagation()

    in0 = $("#invitation0").val()
    in1 = $("#invitation1").val()
    in2 = $("#invitation2").val()
    in3 = $("#invitation3").val()

    for i in [in0, in1, in2, in3]
      if i isnt ""
        $.post("/portfolio/projects/"+ @options.model.id+"/invite", { email: i } )
        
  
    
    
    
