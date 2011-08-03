class Project < ActiveRecord::Base
  
  COVER_DIMENSIONS = { :width => 165, :height => 165 }

  attr_accessible :title, :default, :public, :cover_id, :cover
  attr_reader :cover_name

  #Vaidation
  validates_presence_of :title, :cover, :portfolio

  #Belongs to association
  belongs_to :portfolio
  belongs_to :cover, :class_name => "Image", :foreign_key => "cover_id", :dependent => :destroy

 
  

  #Has_many association
  has_many :invitations, :dependent => :destroy
  has_many :document_blocks, :dependent => :destroy
  has_many :galleries, :dependent => :destroy
  has_many :text_blocks, :dependent => :destroy
  
  before_validation :setup_cover, :if => Proc.new{|f| f.cover.blank? }



  scope :published,  where(:published => true)
  scope :default, where(:default => true)

  def make_default
    if portfolio.present?
      portfolio.projects.each { |p| p.update_attribute(:default, false) }
    end
    self.update_attribute(:default, true)
  end

  def invite(email)
    invitations.create(:email => email).invite_to(portfolio.user)
  end
  
  def upload_cover(file)
    self.setup_cover
    self.cover.upload(file)
    self.cover.save
  end
  
  def elements
    elements = self.galleries | self.document_blocks | self.text_blocks
    elements
  end
  def setup_cover
    self.cover = Image.new(:dir => "#{portfolio.user.username}/projects", :editable => true )
    self.cover.preview_format.update_attributes(COVER_DIMENSIONS)
    self.cover.edit_format.update_attributes(COVER_DIMENSIONS)
    self.cover.display_format.update_attributes(COVER_DIMENSIONS)
    self.cover.save  
  end
  
  
end
