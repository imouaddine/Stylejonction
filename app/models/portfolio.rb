class Portfolio < ActiveRecord::Base
  
  attr_accessible :id, :layout, :theme, :created_at, :updated_at, :user_id
  
  belongs_to :user
  has_many :projects

   
   
end
