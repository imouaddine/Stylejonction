require 'test_helper'

class InvitationsControllerTest < ActionController::TestCase
  def setup
    @user = Factory.create(:user)
    @project = Factory.create(:project, :portfolio => @user.portfolio)
  end

  test "invitation gets created and routing works" do
    @project.invite("ignacy@email.com")

    get :show, :id => @project.invitations.first
    @project.reload
    assert @project.invitations.first.used?, "Should be used"
    assert_in_delta 48.hours.to_f, (@project.invitations.first.expires - Time.now).to_f, 60.0
  end
end
