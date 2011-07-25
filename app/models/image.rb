class Image < ActiveRecord::Base
  mount_uploader :image, ImageUploader
  attr_accessible :image
  belongs_to :thumb_format, :class_name => "ImageFormat", :foreign_key => "thumb_format_id", :dependent => :destroy
  belongs_to :original_format, :class_name => "ImageFormat", :foreign_key => "original_format_id", :dependent => :destroy
  
  before_validation :create_formats, :if => Proc.new {|f| f.new_record?}
  
 
  
  validates :thumb_format, :presence => true
  validates :original_format, :presence => true
  
    
  def set_thumb_dimension(width, height)
    self.thumb_format = ImageFormat.new if self.thumb_format.nil?
    self.thumb_format.update_attributes(:width => width, :height => height)
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
    self.thumb_format.scale_to_fit = true
    self.thumb_format.save
    self.image.recreate_versions!
  end


  private


  protected
    def create_formats
      if self.new_record?
        self.thumb_format = ImageFormat.create(:name => "thumb") unless self.thumb_format.present?
        self.original_format = ImageFormat.create(:name => "original") unless self.original_format.present?
      end
    end

  
end
