class Invitation < ActiveRecord::Base
  validates_presence_of :token, :email
  before_validation :generate_token, :on => :create
  belongs_to :project

  def invite_to(user)
    UserMailer.project_invitation(user, email, project, self)
  end

  protected

  def generate_token
    self.token = Digest::SHA1.hexdigest("#{Time.zone.now.to_i}#{rand}")
  end

end
