class Video < ActiveRecord::Base
   
   belongs_to :gallery
   
   validates_presence_of :weight
end
