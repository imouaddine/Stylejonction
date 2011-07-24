class Project < ActiveRecord::Base

  THUMB_FORMAT_DIMENSIONS = { :width => 165, :height => 165 }

  attr_accessible :title, :default, :public, :cover_id, :cover
  attr_reader :cover_name

  validates_presence_of :title
  
  #Belongs to association
  belongs_to :portfolio
  belongs_to :cover, :class_name => "Image", :foreign_key => "cover_id", :dependent => :destroy
  belongs_to :project_copy, :class_name => "Project", :foreign_key => "project_copy_id", :dependent => :destroy
  
  #Has one to association
  has_one :document_block, :dependent => :destroy
  has_one :gallery, :dependent => :destroy
  has_one :text_block, :dependent => :destroy
  
  #Has_many association
  has_many :invitations, :dependent => :destroy
  
  after_create :create_project_copy_and_cover

  scope :default, where(:default => true)

  def make_default
    if portfolio.present?
      portfolio.projects.each { |p| p.update_attribute(:default, false) }
      portfolio.published_projects.each { |p| p.update_attribute(:default, false) }
    end
    self.update_attribute(:default, true)
  end

  def invite(email)
    invitations.create(:email => email).invite_to(portfolio.user)
  end

  def sync_with_draft
    update_projects_copy
    self.cover.sync_with_draft
  end

  private

  def add_default_cover
    self.cover = Image.new
    self.cover.set_thumb_dimension( THUMB_FORMAT_DIMENSIONS[:width],
                                    THUMB_FORMAT_DIMENSIONS[:height] )
    self.cover.save
  end

  def no_cover_and_no_copy?
    self.cover.nil? && self.project_copy_id.nil?
  end

  def create_project_copy_and_cover
    if self.project_copy.nil?
      add_default_cover if self.cover.blank?
      other = Project.new
      other.title = self.title
      other.project_copy_id = self.id
      other.portfolio_id = self.portfolio_id
      other.cover_id = self.cover.cover_copy_id
      other.default = self.default
      other.public = self.public
      other.published = false
      other.save
      self.project_copy = other
      self.published = true
      save
      self.cover.sync_with_draft
    end
  end

  def update_projects_copy
    other = project_copy
    self.title = other.title
    self.default = other.default
    self.public = other.public
    self.save
  end
end
