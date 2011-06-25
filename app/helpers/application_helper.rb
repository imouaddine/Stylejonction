module ApplicationHelper
  def photo_uploadify
     # Putting the uploadify trigger script in the helper gives us
     # full access to the view and native rails objects without having
     # to set javascript variables.
     #
     # Uploadify is only a queue manager to hand carrierwave the files
     # one at a time. Carrierwave handles capturing, resizing and saving
     # all uploads. All limits set here (file types, size limit) are to
     # help the user pick the right files. Carrierwave is responsible
     # for enforcing the limits (white list file name, setting maximum file sizes)
     #
     # ScriptData:
     #   Sets the http headers to accept javascript plus adds
     #   the session key and authenticity token for XSS protection.
     #   The "FlashSessionCookieMiddleware" rack module deconstructs these 
     #   parameters into something Rails will actually use.

     session_key_name = Rails.application.config.session_options[:key]
     %Q{

     <script type='text/javascript'>
       $(document).ready(function() {
         $('#project_cover').uploadify({
           script          : '/projects/#{@project.id}/upload_image.js',
           fileDataName    : 'project[cover]',
           uploader        : '/uploadify/uploadify.swf',
           cancelImg       : '/assets/images/cancel.png',
           fileDesc        : 'Images',
           fileExt         : '*.png;*.jpg;*.gif',
           sizeLimit       : #{10.megabytes},
           queueSizeLimit  : 1,
           multi           : false,
           auto            : true,
           buttonText      : 'ADD IMAGES',
           scriptData      : {
             '_http_accept': 'application/javascript',
             '#{session_key_name}' : encodeURIComponent('#{u(cookies[session_key_name])}'),
             'authenticity_token'  : encodeURIComponent('#{u(form_authenticity_token)}')
           },
           onComplete      : function(a, b, c, response){ console.log(response); eval(response) }
         });
       });
     </script>

     }.gsub(/[\n ]+/, ' ').strip.html_safe
   end
end
