class Photo < ActiveRecord::Base
  belongs_to :image, :dependent => :destroy
end
