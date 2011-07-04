require 'integration_test_helper'


class UsersTest < ActionDispatch::IntegrationTest
  test "User should login" do
     user = Factory.create(:user)
     visit '/users/sign_in'
     fill_in 'Email', :with => user.email
     fill_in 'Password', :with => user.password
    
     click_button 'Sign in'
  end
  
  
end
