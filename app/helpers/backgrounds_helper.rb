module BackgroundsHelper
  def background_image_tag(background, version = :preview)
    if background && background.background.present?
        image_tag background.background.url(version) , :class => 'preview_uploaded_image'
    else
        image_tag 'http://placehold.it/160x125', :class => 'preview_uploaded_image'
    end
  end
end
