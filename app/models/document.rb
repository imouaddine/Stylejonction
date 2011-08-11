class Document < ActiveRecord::Base
  
  belongs_to :document_block
  
  mount_uploader :file, DocumentUploader
  
  validates_presence_of :caption
  
end
