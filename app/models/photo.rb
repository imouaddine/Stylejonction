class Photo < ActiveRecord::Base
  has_image
  
  
  attr_accessible :caption, :image_id, :gallery_id, :image_attributes
  
  PREVIEW_DIMENSIONS = { :width => 87, :height => 65 }
  EDIT_DIMENSIONS = { :width => 165, :height => 165 }
  
 
  
  belongs_to :gallery
  
  validates_presence_of :weight, :gallery_id
  
  accepts_nested_attributes_for :image
  
  def setup_image
    self.image = Image.new(:dir => "#{gallery.project.portfolio.user.username}/projects/gallery/#{gallery.id}/photos/", :editable => true )
    self.image.preview_format.update_attributes(PREVIEW_DIMENSIONS)
    self.image.edit_format.update_attributes(EDIT_DIMENSIONS)
    self.image.display_format.update_attributes(PREVIEW_DIMENSIONS)
    self.image.save  
  end
  
  
  
end
