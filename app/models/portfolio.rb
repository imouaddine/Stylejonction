class Portfolio < ActiveRecord::Base
  
  attr_accessible :id, :layout, :theme, :created_at, :updated_at, :user_id, :background_id, :title_font_id, :body_font_id, :layout_id, :body_color, :title_colo, :background_type, :published, :title_color

  belongs_to :user
  has_many :projects
  
  belongs_to :title_font, :class_name => "Font", :foreign_key => "title_font_id"
  belongs_to :body_font, :class_name => "Font", :foreign_key => "body_font_id"
   
  belongs_to :background, :polymorphic => true
  belongs_to :layout

  def has_saved_project?
    projects.present? && !projects.first.new_record?
  end
   
  def publish!
    self.published = true
    save!
  end

  def published=(value) 
    unless published?
      write_attribute(:published, value)
    end
  end

end
