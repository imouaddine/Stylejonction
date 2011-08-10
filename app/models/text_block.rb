class TextBlock < Element
  
  belongs_to :project
  
  validates_presence_of :title, :project_id
  
end
