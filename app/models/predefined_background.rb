class PredefinedBackground < ActiveRecord::Base
  has_image 
  
  PREVIEW_BACKGROUND_FORMAT = {:width => 160, :height => 125}
  has_many :portfolios, :as => :background
  
  attr_accessible :name
  def as_json(options={})
    super(
             :include => [:image]
             
    )
 end
 
  protected
  def setup_image
    if self.image.nil?
      self.image = Image.new(:dir => 'predefined_backgrounds')
      self.image.preview_format.update_attributes(PREVIEW_BACKGROUND_FORMAT)
      self.image.preview_format.scalable = true
      self.image.preview_format.croppable = false
      self.image.edit_format.update_attributes(PREVIEW_BACKGROUND_FORMAT)
      self.image.preview_format.scalable = true
      self.image.preview_format.croppable = false
      self.image.display_format.update_attributes(:croppable => false, :scalable => false)
      self.image.save
    end
  end
  
end
