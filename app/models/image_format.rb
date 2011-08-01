class ImageFormat < ActiveRecord::Base
   FORMATS = %w{edit preview display}
   
   attr_accessible :height, :width, :crop_x, :crop_y, :croppable, :scalable, :format
   
   has_one :image

   validates_inclusion_of :format, :in => FORMATS, :message => "%s should be one of #{FORMATS}"

   validates :height,  :numericality => true, :allow_nil => true
   validates :width,  :numericality => true, :allow_nil => true

   validates_numericality_of :crop_x
   validates_numericality_of :crop_y
   
  
   def crop(x, y)
      self.crop_x = x
      self.crop_y = y
      self.scale_to_fit = false
      self.save
      
    end

    def scale_to_fit(value)
      self.scale_to_fit = value
      self.save
    end

end
