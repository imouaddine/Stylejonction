class Photo < ActiveRecord::Base
  belongs_to :image, :dependent => :destroy
  
  belongs_to :gallery
  
  validates_presence_of :weight, :gallery_id
  
end
