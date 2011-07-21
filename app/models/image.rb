class Image < ActiveRecord::Base
  mount_uploader :image, ImageUploader
  attr_accessible :image
  belongs_to :thumb_format, :class_name => "ImageFormat", :foreign_key => "thumb_format_id"
  belongs_to :original_format, :class_name => "ImageFormat", :foreign_key => "original_format_id"

  after_initialize :create_formats
  validates :thumb_format, :presence => true
  validates :original_format, :presence => true

  belongs_to :cover_copy, :class_name => "Image", :foreign_key => "cover_copy_id", :dependent => :destroy
  after_create :create_cover_copy

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
    self.thumb_format.scale_to_fit = true
    self.thumb_format.save
    self.image.recreate_versions!
  end

  private

  def create_cover_copy
    if self.cover_copy.nil?
      other = Image.new
      other.image = self.image
      other.cover_copy_id = self.id
      other.thumb_format_id = self.thumb_format_id
      other.original_format_id = self.original_format_id
      other.published = false
      other.save
      self.cover_copy = other
      self.published = true
      save
    end
  end

  protected

  def create_formats
    self.create_thumb_format(:name => "thumb") unless self.thumb_format.present?
    self.create_original_format(:name => "original") unless self.original_format.present?
  end
end
