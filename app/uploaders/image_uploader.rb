# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick


  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.dir}/#{model.id}"
  end
  
  
  # Provide a default URL as a default if there hasn't been a file uploaded:
  def default_url
     "/public/assets/images/fallback/#{model.class.to_s.underscore}_default.jpg" 
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
    puts "Format #{format}"
    puts image_format.inspect
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
      w = img.columns
      h = img.rows
      img
    end
  end
  def  ssss
     #scaling
      if image_format.scalable?  && image_format.height > 0 && image_format.width > 0
        if image_format.scale_to_fit? 
          img.resize_to_fit(image_format.width, image_format.height)
        else
          format_width = image_format.width.to_f
          format_height = image_format.height.to_f
            
          puts "Image dimensions: #{width} #{height}"
          puts "Format dimensions: #{format_width} #{format_height}"

          if(format_height < format_width)
            scale = format_height / [width, height].min
          else
            scale = format_width / [width, height].min
          end
          puts "Scale: #{scale}"
          #img.resize_to_fit!(width * scale, height * scale)
          puts "Image resize #{width * scale} #{height * scale}"
        end
      end
      #cropping
     
      if !image_format.scale_to_fit?  && image_format.croppable?
         puts "Cropping"
         if (image_format.width > 0  && image_format.height > 0)
            #img.crop(image_format.crop_x, image_format.crop_y, image_format.width, image_format.height)
          else
            #img.crop(image_format.crop_x, image_format.crop_y, width - image_format.crop_x, height - image_format.crop_y)
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
