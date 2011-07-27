class Gallery < ActiveRecord::Base
  DISPLAY_PREFERENCES = %w{slideshow mosaic}
  
  belongs_to :project
  
  has_many :videos, :dependent => :destroy
  has_many :photos, :dependent => :destroy
  
  validates :display_preference, :presence => true
  validates_inclusion_of :display_preference, :in => DISPLAY_PREFERENCES, :message => "%s should be one of #{DISPLAY_PREFERENCES}"
  
end
