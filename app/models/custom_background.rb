require 'image_extensions'
class CustomBackground < ActiveRecord::Base
  has_image 
  
  PREVIEW_BACKGROUND_FORMAT = {:width => 160, :height => 125}
  attr_accessible :display_mode, :background, :user_id, :user
  
  accepts_nested_attributes_for :image
   
  DISPLAY_MODES = %w{tile stretch original}
  
  validates_inclusion_of :display_mode, :in => DISPLAY_MODES, :message => "Display mode should be one of #{DISPLAY_MODES}"
  validates_presence_of :user, :display_mode

     
     
  has_many :portfolios, :as => :background
  belongs_to :user
  
  
  
  
  
  def setup_image
      self.image = Image.new( :dir => "#{self.user.username}/custom_backgrounds")
      self.image.preview_format.update_attributes(PREVIEW_BACKGROUND_FORMAT)
      self.image.preview_format.croppable = true
      self.image.preview_format.scalable = true
      self.image.preview_format.save
      self.image.edit_format.update_attributes(PREVIEW_BACKGROUND_FORMAT)
      self.image.edit_format.croppable = false
      self.image.edit_format.scalable = true
      self.image.edit_format.save
      self.image.display_format.update_attributes(:croppable => true, :scalable => false)
  end
  
end
