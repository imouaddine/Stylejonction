class Image < ActiveRecord::Base
  mount_uploader :image, ImageUploader

  #validates_integrity_of :image
  #validates_processing_of :image
  validates_presence_of :dir
  
  validate :image, 
     :file_size => { 
       :maximum => 5.megabytes.to_i 
     }
     
  attr_accessible :image, :dir, :edit_format, :preview_format, :display_format, :editable, :scale_to_fit
  
  belongs_to  :edit_format, :foreign_key => 'edit_format_id',  :class_name => "ImageFormat", 
              :dependent => :destroy,  :autosave => true
              
  belongs_to  :preview_format, :foreign_key => 'preview_format_id',  :class_name => "ImageFormat", 
              :dependent => :destroy,  :autosave => true
              
  belongs_to  :display_format, :foreign_key => 'display_format_id',  :class_name => "ImageFormat", 
              :dependent => :destroy,  :autosave => true
  
  after_initialize :create_formats
 
  
 
  
  def url(format)
    image.url(format)
  end
  
  def uploaded?
    !self.image.blank?
  end
  
  def edit_url
    image.url(:edit)
  end
  def preview_url
    image.url(:preview)
  end
  def display_url
    image.url(:display)
  end
  
  def image_formats
    [edit_format, preview_format,  display_format]
  end
  
  def image_format(format)
    return self.edit_format if format == :edit
    return self.display_format if format == :display
    return self.preview_format if format == :preview 
  end
  
  def upload(file)
    self.image.store!(File.open(File.join(Rails.root, file)))
  end
  
  def update_versions
    self.recreate_versions!
  end
  
  def delete_image!
    if self.uploaded?
      self.remove_image!
      self.remove_image = true
    end
  end
  
  def crop(x, y)
    self.image_formats.each do |image_format|
      if image_format.croppable?
        image_format.crop(x,y)
      end
    end
    self.scale_to_fit = false
    self.image.recreate_versions!
    self.save
  end
 
  def scale_to_fit=(value)
    if value != @scale_to_fit
      super(value)
      self.image.recreate_versions!
    end
  end
  
  
  protected
    def create_formats
      self.edit_format = ImageFormat.new(:format => 'edit', :croppable => false) if self.edit_format.nil?
      self.preview_format = ImageFormat.new(:format => 'preview') if self.preview_format.nil?
      self.display_format = ImageFormat.new(:format => 'display', :scalable => false) if self.display_format.nil?
    end
    

  
    
end
