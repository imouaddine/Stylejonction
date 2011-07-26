class Project < ActiveRecord::Base

  THUMB_FORMAT_DIMENSIONS = { :width => 165, :height => 165 }

  attr_accessible :title, :default, :public, :cover_id, :cover
  attr_reader :cover_name

  #Vaidation
  validates_presence_of :title, :cover

  #Belongs to association
  belongs_to :portfolio
  belongs_to :cover, :class_name => "Image", :foreign_key => "cover_id", :dependent => :destroy

  #Has one to association
  has_one :document_block, :dependent => :destroy
  has_one :gallery, :dependent => :destroy
  has_one :text_block, :dependent => :destroy

  #Has_many association
  has_many :invitations, :dependent => :destroy

  before_validation :add_default_cover

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


  protected
  def add_default_cover
    if self.cover.nil?
      self.cover = Image.new
      self.cover.set_thumb_dimension( THUMB_FORMAT_DIMENSIONS[:width], THUMB_FORMAT_DIMENSIONS[:height] )
      self.cover.save
    end
  end
end
