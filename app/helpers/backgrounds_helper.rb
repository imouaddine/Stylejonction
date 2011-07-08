module BackgroundsHelper
  def background_image_tag(background, version = :preview)
    if background && background.background.present?
        image_tag background.background.url(version) 
    else
        image_tag 'http://placehold.it/160x125'
    end
  end
end
