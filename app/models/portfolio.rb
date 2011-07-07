class Portfolio < ActiveRecord::Base
  
  attr_accessible :id, :layout, :theme, :created_at, :updated_at, :user_id, :background_id, :title_font_id, :body_font_id, :layout_id, :body_color, :title_colo, :background_type, :published, :title_color, :background

  belongs_to :user
  has_many :projects
  
  belongs_to :title_font, :class_name => "Font", :foreign_key => "title_font_id"
  belongs_to :body_font, :class_name => "Font", :foreign_key => "body_font_id"
   
  belongs_to :background, :polymorphic => true
  belongs_to :layout

  after_create :set_default_attributes

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
  
  
  def custom_background_url( version = :preview)
    background.background.url(version) if background 
  end


  private

  def set_default_attributes
    self.background = PredefinedBackground.first if (PredefinedBackground.count > 0)
    self.layout = Layout.find_by_name("left") if (Layout.count > 0)
    if Font.count > 0
      self.title_font = Font.first
      self.body_font = Font.first
    end
    save!
  end

end

