class DocumentBlock < ActiveRecord::Base
  has_many :documents , :dependent => :destroy

  belongs_to :project 
  
  
end
