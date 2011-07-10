require 'test_helper'

class InvitationTest < ActiveSupport::TestCase
  test "invitation is unused on default" do

    invite = Invitation.create!(:email => "janusz@gmail.com")

    assert_equal false, invite.used?
    assert invite.token.present?, "No token present"
  end
end
