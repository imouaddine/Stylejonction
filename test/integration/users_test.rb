require 'integration_test_helper'


class UsersTest < ActionDispatch::IntegrationTest
  test "User should login" do
    loggin
    assert_equal "USER's portfolio", find("#title").text
  end
end
