class DocumentBlock < Element
  has_many :documents , :dependent => :destroy, :order  => 'weight'

  belongs_to :project 
  
  validates_presence_of :title, :project_id
end
