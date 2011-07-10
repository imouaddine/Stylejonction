class Project < ActiveRecord::Base

  validates_presence_of :title
  belongs_to :portfolio

  scope :default, where(:default => true)
  mount_uploader :cover, CoverUploader

  def set_to_default
    if portfolio.present?
      portfolio.projects.each do |p|
        p.update_attribute(:default, false)
      end
    end

    self.default = true
    self.save
  end
end
