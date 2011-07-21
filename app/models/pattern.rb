class Pattern < ActiveRecord::Base
  has_many :pattern_backgrounds
  
  mount_uploader :pattern, BackgroundUploader
 
  
end
