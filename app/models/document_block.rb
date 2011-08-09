class DocumentBlock < ActiveRecord::Base
  has_many :documents , :dependent => :destroy

  belongs_to :project 
  
  validates_presence_of :title, :project_id
end
