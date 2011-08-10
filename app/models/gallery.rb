class Gallery < Element
  DISPLAY_PREFERENCES = %w{slideshow mosaic}
  
  belongs_to :project
  
  has_many :videos, :dependent => :destroy, :order => 'weight'
  has_many :photos, :dependent => :destroy, :order => 'weight'
  
  validates_presence_of :title, :display_preference, :project_id

  validates_inclusion_of :display_preference, :in => DISPLAY_PREFERENCES, :message => "%s should be one of #{DISPLAY_PREFERENCES}"
  
  def elements
    elements = self.videos + self.photos
    elements.delete_if {|x| x.weight == nil}
    elements.sort_by(&:weight)
  end
  
  
end
