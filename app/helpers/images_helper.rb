module ImagesHelper
  
  def image_display (image, options ={})
   image(image, :display, options)
  end
  
  def image_preview (image, options ={})
    image(image, :preview, options)
  end
  
  def image_edit (image, options ={})
    image(image, :edit, options)
  end
  
  def image (image, format, options = {})
    return if image.nil?
    if  !image.uploaded?
      "<figure class='image_#{format} #{options[:class]}'>#{image_tag options[:fallback]}</figure>".html_safe
    else
      content_tag_for :figure, image, :class => "image_#{format}" do
        image_tag image.url(format), options
      end
    end
  end
  
end
