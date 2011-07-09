class Portfolio < ActiveRecord::Base
  THEMES = %w{light dark}

  attr_accessible(:id, :layout, :theme, :created_at, :updated_at,
                  :user_id, :background_id, :title_font_id,
                  :body_font_id, :layout_id, :background_type,
                  :published, :background, :background_display_mode,
                  :custom_background_id, :pattern_background_id, :predefined_background_id)

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

  def title_color
    title_font.color
  end

  def body_color
    body_font.color
  end

  def has_custom_background?
    !!(background_type == 'CustomBackground')
  end
  def has_pattern_background?
    !!(background_type == 'PatternBackground')
  end
  def has_predefined_background?
    !!(background_type == 'PredefinedBackground')
  end


  def background_display_mode=(value)
    self.custom_background.display_mode = value
    self.custom_background.save
  end

  private

  def set_default_attributes
    self.background = PredefinedBackground.first if (PredefinedBackground.count > 0)
    self.theme = THEMES.first
    # self.predefined_background = self.background
    # self.custom_background = CustomBackground.create(:user => self.user)
    # self.pattern_background = PatternBackground.create( :pattern => Pattern.first, :color => '000000')
    self.layout = Layout.find_by_name("left") if (Layout.count > 0)
    if Font.count > 0
      self.title_font = Font.first
      self.body_font = Font.first
    end
    save!
  end

end
