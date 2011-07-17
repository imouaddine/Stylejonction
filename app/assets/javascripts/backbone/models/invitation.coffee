class Stylejonction.Models.Invitation extends Stylejonction.Models.Base
   paramRoot: 'invitation'
   url: "/portfolio/projects/:id/invite"

   initialize: ()->
     super
     @.url = @.url.replace ':id', @.id