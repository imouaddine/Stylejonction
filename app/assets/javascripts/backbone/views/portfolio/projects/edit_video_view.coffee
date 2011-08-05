Stylejonction.Views.Projects ||= {}
class Stylejonction.Views.Projects.EditVideoView extends Backbone.View
  el: '#edit_video_section'
  
  events:
    "click #upload_video" : "uploadVideo"
    "click  #save_video":          "save"
  
  
  uploadVideo: (e)->
    e.preventDefault()
    e.stopPropagation()
    url = escape($("#video_url").val());
    api_url = 'http://api.embed.ly/1/oembed?key=973eeacebed911e089f94040d3dc5c07&url=' + url + '&callback=?'
    
    #jQuery JSON call
    $.getJSON( api_url, (json) ->
        html = json.html
        $("#video_html").val(json.html)
        $("#video_preview").html("<img width='200' src=#{json.thumbnail_url}></img>")
        $("#video_width").val(json.width)
        $("#video_height").val(json.height)
        $("#video_thumbnail_width").val(json.thumbnail_width)
        $("#video_thumbnail_height").val(json.thumbnail_height)
        $("#video_thumbnail_url").val(json.thumbnail_url)
        $("#video_caption").html(json.title);
    )
    
    
  save: (e)->
    e.preventDefault()
    e.stopPropagation()
    $("#new_video, #edit_video").submit()
    $.fancybox.close()
    
