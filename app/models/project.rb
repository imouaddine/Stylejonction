class Project < ActiveRecord::Base

  THUMB_FORMAT_DIMENSIONS = { :width => 165, :height => 165 }

  attr_accessible :title, :default, :public, :cover_id

  validates_presence_of :title
  belongs_to :portfolio

  has_many :invitations, :dependent => :destroy
  belongs_to :cover, :class_name => "Image", :foreign_key => "cover_id", :dependent => :destroy

  scope :default, where(:default => true)

  after_create :add_default_cover

  def set_to_default
    if portfolio.present?
      portfolio.projects.each do |p|
        p.update_attribute(:default, false)
      end
    end

    self.default = true
    self.save
  end

  def invite(email)
    invitations.create(:email => email).invite_to(portfolio.user)
  end

  private
    def add_default_cover
      if self.cover.nil?
         self.cover = Image.new
         self.cover.set_thumb_dimension( THUMB_FORMAT_DIMENSIONS[:width], THUMB_FORMAT_DIMENSIONS[:height] )
         self.cover.save!
      end
    end
end
