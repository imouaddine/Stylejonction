Stylejonction.Views.Backgrounds ||= {}

class Stylejonction.Views.Backgrounds.EditView extends Backbone.View
  events:
    "change input[name='display_mode']"    : "updateBgDisplayMode"
    
  updateBgDisplayMode: (e)->
    e.preventDefault()
    e.stopPropagation()
    target = $(e.currentTarget)
    @options.model.fetch(
      success: (e)->
        e.set({'display_mode': target.val() })
        e.save()
    )
