class Photo < ActiveRecord::Base
  belongs_to :image, :dependent => :destroy
  
  belongs_to :gallery, :dependent => :destroy
  
  validates_presence_of :weight
  
end
