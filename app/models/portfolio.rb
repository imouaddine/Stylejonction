class Portfolio < ActiveRecord::Base
  include BackgroundValidator
  
  THEMES = %w{light dark}
  LAYOUTS = %w{left top right bottom}


  attr_accessible(:id, :layout, :theme, :created_at, :updated_at, :user_id,
                  :background_id, :title_font_id, :body_font_id,
                  :body_color, :background_type, :published, :title_color,
                  :background, :custom_background_id,
                  :pattern_background_id, :predefined_background_id, :pattern_background_attributes)

  validates_inclusion_of :layout, :in => LAYOUTS, :message => "Layout % should be one of #{LAYOUTS}"
  validates_inclusion_of :theme, :in => THEMES, :message => "Theme  %s should be one of #{THEMES}"
  validates_presence_of :user
  
  belongs_to :user
  has_many :projects, :dependent => :destroy
  
  belongs_to :title_font, :class_name => "Font", :foreign_key => "title_font_id"
  belongs_to :body_font, :class_name => "Font", :foreign_key => "body_font_id"

  belongs_to :background, :polymorphic => true
  belongs_to :predefined_background
  belongs_to :custom_background
  belongs_to :pattern_background
  
  accepts_nested_attributes_for :pattern_background, :custom_background

  after_create :set_default_attributes

  validates :custom_background_id, :custom_background => true, :unless => lambda { |p| p.custom_background_id.nil? }
  validates :predefined_background_id, :predefined_background => true, :unless => lambda { |p| p.predefined_background_id.nil? }
  validates :pattern_background_id, :pattern_background => true, :unless => lambda { |p| p.pattern_background_id.nil? }
  
  def publish!
    self.published = true
    self.save
  end
  
  
  def has_saved_project?
    projects.present? && !projects.first.new_record?
  end
 
  def published=(value)
    if value
      write_attribute(:published, value)
    end
  end

  def has_custom_background?
    self.background.present? && self.background_type == 'CustomBackground'
  end
  def has_pattern_background?
    self.background.present? && self.background_type == 'PatternBackground'
  end
  def has_predefined_background?
    self.background.present? && self.background_type == 'PredefinedBackground'
  end

  protected
  
  def set_default_attributes
    #set background prefefined background
    self.background = PredefinedBackground.first if (PredefinedBackground.count > 0)
    self.predefined_background = self.background
    
    #set custom background
    self.custom_background = CustomBackground.create(:user => self.user)
    self.custom_background.setup_image
    self.custom_background.save
    
    #set pattern background
    self.pattern_background = PatternBackground.create( :pattern => Pattern.first, :color => '000000')
    
    if Font.count > 0
      self.title_font = Font.first
      self.body_font = Font.first
    end
    
    save!
  end
end
