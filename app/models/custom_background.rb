class CustomBackground < ActiveRecord::Base
  DISPLAY_MODES = %w{tile stretch original}
  validates_inclusion_of :display_mode, :in => DISPLAY_MODES, 
    :message => "Display mode should be one of #{DISPLAY_MODES}"
    
  mount_uploader :background, BackgroundUploader
  has_many :portfolios, :as => :background
  belongs_to :user
  
  after_initialize :init
  
  def init
    self.display_mode ||= 'original'
  end
  
end
