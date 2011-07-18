class ImageFormat < ActiveRecord::Base
   FORMATS = %w{original thumb}

   belongs_to :image

   validates_inclusion_of :name, :in => FORMATS, :message => "%s should be one of #{FORMATS}"

   validates :height,  :numericality => true, :allow_nil => true
   validates :width,  :numericality => true, :allow_nil => true

  validates_numericality_of :crop_x
  validates_numericality_of :crop_y

end
