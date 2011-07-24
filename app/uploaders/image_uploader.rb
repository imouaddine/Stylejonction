# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick


  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  version :editable_thumb do
    process :scale_thumb
  end

  version :thumb do
    process :scale_thumb
    process :crop_thumb
  end

  def scale_thumb
    manipulate! do |image|
      if self.model.thumb_format.scale_to_fit?
        image.resize_to_fit self.model.thumb_format.width, self.model.thumb_format.height
      else
        width = image.columns
        height = image.rows

        thumb_height = self.model.thumb_format.height
        thumb_height = 165 unless thumb_height

        scale = [width, height].min / thumb_height
        image.resize_to_fit(width / scale, height/scale)
      end
    end
  end

  def crop_thumb
    if !self.model.thumb_format.scale_to_fit?
      manipulate! do |image|

        #TODO fix me: I want to make the cover work fast then
        # I'll fix the defaults
        #image.crop(self.model.thumb_format.crop_x, self.model.thumb_format.crop_y, self.model.thumb_format.width, self.model.thumb_format.height)

        image.crop(10, 10, 165, 165)
      end
    end
  end


  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(jpg jpeg gif png)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

end
