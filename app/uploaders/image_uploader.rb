# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick


  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.dir}/#{model.id}"
  end
  
  # Create different versions of your uploaded files:
  version :preview do
    process :process_format => :preview
  end
  version :edit do
    process :process_format => :edit
  end
  version :display do
    process :process_format => :display
  end

  def process_format(format)
    image_format = self.model.image_format(format)
    if self.model.editable?
      process_editable_image(image_format)
    else
      process_non_editable_image(image_format)
    end
  end
  
  #simple resizing 
  def process_non_editable_image(image_format)
    if image_format.height > 0 && image_format.width > 0
      manipulate! do |img|
        self.model.width = img.columns
        self.model.height = img.rows
        img.resize_to_fit(image_format.width, image_format.height)
      end
    end
  end
 
  def process_editable_image(image_format)
    manipulate! do |img|
      width = img.columns
      height = img.rows
      if self.model.scale_to_fit? 
        img.resize_to_fit!(image_format.width, image_format.height)
      else
        format_width = image_format.width.to_f
        format_height = image_format.height.to_f
        
        if(format_height < format_width)
            scale = format_height / [width, height].min
        else
            scale = format_width / [width, height].min
        end
        
        img.resize_to_fit!(width * scale, height * scale)
      end
      if (image_format.croppable? && image_format.width > 0  && image_format.height > 0)
        img.crop!(image_format.crop_x, image_format.crop_y, image_format.width, image_format.height)
      end
      img
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
