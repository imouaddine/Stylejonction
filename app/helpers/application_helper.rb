module ApplicationHelper

  def iviewer(element, image_path, fit_button, image_format)
    %Q{
       <script type='text/javascript'>
          image_format = eval(#{image_format});
          image_format.scale_to_fit = Boolean(image_format.scale_to_fit);
          zoom_val = image_format.scale_to_fit? 'fit' : 100;

           $('#{element}').iviewer({
              src: '#{image_path}',
              update_on_resize: false,
              ui_disabled: false,
              zoom: zoom_val,
              initCallback: function ()
              {
                var object = this;
                object.zoom_by(1);
                top = -parseFloat(image_format.crop_y);
                left = -parseFloat(image_format.crop_x);
                $("#cover_editor img").css("top", top);
                $("#cover_editor img").css("left", left);

                $('#{fit_button}').change(function(){
                  if( $(this).is(':checked') ){
                    object.fit();
                  }
                  else{
                    object.zoom_by(1);
                  }
                });




              }
           });
      </script>

     }.gsub(/[\n ]+/, ' ').strip.html_safe

  end
  def photo_uploadify(element_selector, image_selector, script_path, fileDataName)
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
#/portfolio/projects/#{@project.id}/upload_cover.js
     session_key_name = Rails.application.config.session_options[:key]
     %Q{

     <script type='text/javascript'>
       $(document).ready(function() {
         var image_selector = $('#{image_selector}');
         $('#{element_selector}').uploadify({
           script          : '#{script_path}',
           fileDataName    : '#{fileDataName}',
           uploader        : '/uploadify/uploadify.swf',
           cancelImg       : '/images/cancel.png',
           buttonImg        : '/images/upload_btn.png',
           fileDesc        : 'Upload',
           fileExt         : '*.png;*.jpg;*.gif',
           sizeLimit       : #{10.megabytes},
           queueSizeLimit  : 1,
           multi           : false,
           auto            : true,
           buttonText      : 'Upload',
           width            : 76,
           height   : 40,
           scriptData      : {
             '_http_accept': 'application/javascript',
             '#{session_key_name}' : encodeURIComponent('#{u(cookies[session_key_name])}'),
             'authenticity_token'  : encodeURIComponent('#{u(form_authenticity_token)}')
           },
           onComplete : function(a, b, c, response){  if(image_selector.length > 0) {
                                                          image_selector.html(response).trigger('change');
                                                          $('#project_cover_name').val(c.name);
                                                       }
                                                      else {
                                                        console.log(response);
                                                        eval(response.replace(/'/g, "\'"));
                                                      }
                                                  }
         });
       });
     </script>
     }.gsub(/[\n ]+/, ' ').strip.html_safe
   end


   def section_link(body, url, html_options = {})
       if html_options[:action] == @current_action and html_options[:controller] == @current_controller
          html_options[:class] = 'selected'
          link_to(body, url, html_options)
       else
          link_to(body, url, html_options)
       end
   end

   

end
