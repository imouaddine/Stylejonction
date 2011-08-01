class Pattern < ActiveRecord::Base
  has_image
  
  PATTERN_FORMAT = {:width => 25, :height => 25, :croppable => false, :scalable => true}
  has_many :pattern_backgrounds
  
  attr_accessible :image
  

  
  protected
   def setup_image
     if self.image.nil?
       self.image = Image.new(:dir => 'patterns')
       self.image.preview_format.update_attributes(PATTERN_FORMAT)
       self.image.edit_format.update_attributes(PATTERN_FORMAT)
       self.image.display_format.update_attributes(PATTERN_FORMAT)
       self.image.save
     end
     
   end
   
   
   
end
