class UserMailer < ActionMailer::Base
  default from: "from@example.com"

  def project_invitation(user, email, project, invitation)
    @mail = email
    @user = user
    @project = project
    @invitation = invitation

    mail(:to => "<#{email}>", :subject => "Invitation")
  end
end
