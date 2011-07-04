class Font < ActiveRecord::Base
  has_many :portfolios
  
  scope :webfont , where(:webfont => true, :visible => true)
  scope :non_webfont , where(:webfont => false, :visible => true)
 
end
