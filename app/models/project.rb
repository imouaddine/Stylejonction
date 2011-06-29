class Project < ActiveRecord::Base
  
  validates_presence_of :title 
  belongs_to :portfolio
  
  mount_uploader :cover, CoverUploader
  
  
end
