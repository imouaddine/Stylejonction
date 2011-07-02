class Portfolio < ActiveRecord::Base
  
  attr_accessible :id, :layout, :theme, :font, :created_at, :updated_at, :user_id
  
  belongs_to :user
  has_many :projects

  def has_saved_project?
    projects.present? && !projects.first.new_record?
  end
   
   
end
