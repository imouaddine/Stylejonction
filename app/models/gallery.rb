class Gallery < ActiveRecord::Base
  
  belongs_to :project
  
  has_many :videos, :dependent => :destroy
  has_many :photos, :dependent => :destroy
  
end
