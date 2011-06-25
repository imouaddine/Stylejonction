class Project < ActiveRecord::Base
  

  belongs_to :portfolio
  
  mount_uploader :cover, CoverUploader
  
  
end
