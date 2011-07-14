class Stylejonction.Models.Invitation extends Backbone.Model
   paramRoot: 'invitation'
   url: "/portfolio/projects/:id/invite"

   initialize: ()->
     @.url = @.url.replace ':id', @.id