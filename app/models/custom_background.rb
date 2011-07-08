class CustomBackground < ActiveRecord::Base
  
   attr_accessible :display_mode, :background, :user_id
   
   mount_uploader :background, BackgroundUploader
   
  DISPLAY_MODES = %w{tile stretch original}
  
  validates_inclusion_of :display_mode, :in => DISPLAY_MODES, :message => "Display mode should be one of #{DISPLAY_MODES}"
    
  validate :background, 
     :file_size => { 
       :maximum => 5.megabytes.to_i 
     }
     
     
  has_many :portfolios, :as => :background
  belongs_to :user
  
  after_initialize :init
  
  def init
    self.display_mode ||= 'original'
  end
  
end
