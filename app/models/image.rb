class Image < ActiveRecord::Base
  mount_uploader :image, ImageUploader
  
  belongs_to :thumb_format, :class_name => "ImageFormat", :foreign_key => "thumb_format_id"
  belongs_to :original_format, :class_name => "ImageFormat", :foreign_key => "original_format_id"
  after_initialize :after_initialize
  
  validates :thumb_format, :presence => true
  validates :original_format, :presence => true
  
  
  def set_thumb_dimension(width, height)
    self.thumb_format.width = width
    self.thumb_format.height = height
    self.thumb_format.save
  end
  
  def thumb_url
    if self.image
      self.image.url(:thumb)
    else 
      "http://placehold.it/#{self.thumb_format.width}x#{self.thumb_format.height}"
    end
  end
  
  def crop(x, y)
     self.thumb_format.crop_x = x 
     self.thumb_format.crop_y = y
     self.thumb_format.scale_to_fit = false
     self.thumb_format.save
     self.image.recreate_versions!
   end

   def scale_to_fit
      puts self.thumb_format.inspect
      self.thumb_format.scale_to_fit = true
      self.thumb_format.save
      self.image.recreate_versions!
   end
   
  protected
  def after_initialize
    self.create_thumb_format(:name => "thumb") unless self.thumb_format.present?
    self.create_original_format(:name => "original") unless self.original_format.present?
  end
  
end