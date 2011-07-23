class Font < ActiveRecord::Base
  has_many :portfolios
  
  scope :webfont , where(:webfont => true, :visible => true)
  scope :non_webfont , where(:webfont => false, :visible => true)
  scope :body_font, where(:body_font => true)
  scope :title_font, where(:title_font => true)
 
end
