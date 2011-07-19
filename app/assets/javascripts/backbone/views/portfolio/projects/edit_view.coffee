Stylejonction.Views.Projects ||= {}
class Stylejonction.Views.Projects.EditView extends Backbone.View

  events:
    "change #project_title":          "update"
    "change #project_default":      "update"
    "click #public_project_btn":    "update_visibility_public"
    "click #private_project_btn":   "update_visibility_private"
    "click #send_invites":          "send_invites"
    "change #cover"                 :"cover_changed"

  initialize: ()->
    _.bindAll(this, 'showCover', 'on_fancybox_complete')
    @project = @options.model

    @cover = @project.cover

    @cover.bind 'change', @.showCover
    $("#edit_project").tabs()

    @.init_fancybox()

  init_fancybox: ()->
    $(".iframe_fancy").fancybox
      hideOnContentClick: false,
      showCloseButton: true,
      padding: 0,
      onComplete: @.on_fancybox_complete

  on_fancybox_complete: ()->
    @edit_cover_view = new Stylejonction.Views.Images.EditView({image: @cover})
    @edit_cover_view.bind 'change', @.showCover

  update: (e) ->
    e.preventDefault()
    e.stopPropagation()

    title = $(e.currentTarget).val()
    default_project = $("#project_default").is(":checked")

    @options.model.set({'title' : title, 'default' : default_project})

  update_visibility_public: (e) ->
    e.preventDefault()
    e.stopPropagation()

    @.$("#public_project").show("medium")
    @.$("#private_project").hide("medium")

    @.$("#private_project_btn").removeClass("selected")
    @.$("#public_project_btn").addClass("selected")

    @project.set( {'public' : true} )
    $("#project_public").val('t')


  update_visibility_private: (e) ->
    e.preventDefault()
    e.stopPropagation()

    @.$("#private_project").show("medium")
    @.$("#public_project").hide("medium")

    @.$("#public_project_btn").removeClass("selected")
    @.$("#private_project_btn").addClass("selected")

    @project.set({'public' : false})
    $("#project_public").val('f')

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

  cover_changed: (e)->
    @project.fetch()

  showCover: (cover)->
    @project.cover = cover;
    @project.trigger('change')
    #force loading image from the server using timestamp
    timestamp = new Date().getTime();

    $("#cover img").attr('src', "#{cover.toJSON().image.thumb.url}?#{timestamp}")





