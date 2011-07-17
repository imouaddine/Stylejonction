Stylejonction.Views.Projects ||= {}
class Stylejonction.Views.Projects.EditCoverView extends Backbone.View
  
  initialize: (options)->
    @project = options.project
    @cover = @project.cover
      
  events:
    "click #submit" : "submit"
    
  submit: ->
    object = $('#cover_editor').data('viewer').img_object;
    x = -object.x;
    y = -object.y;
    
    if $("#scale_to_fit").is(":checked")
      $.post "#{@cover.url}#{@cover.id}/scale_to_fit.json", {scale_to_fit: true}
    else
      $.post "#{@cover.url}#{@cover.id}/crop.json",  { x: x, y: y }
  
    
    
    
   
