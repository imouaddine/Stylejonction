require 'test_helper'

class InvitationsControllerTest < ActionController::TestCase
  def setup
    @user = Factory.create(:user)
    @invited_user = Factory.create(:user, :email => "ignacy@email.com")
    @project = @user.portfolio.projects.first
  end

  test "invitation gets created and routing works" do
    @project.invite(@invited_user.email)
    sign_in @invited_user
    get :show, :id => @project.invitations.first
    @project.reload
    assert @project.invitations.first.used?, "Should be used"
    assert_in_delta 48.hours.to_f, (@project.invitations.first.expires - Time.now).to_f, 60.0
  end
end
