require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  include Devise::TestHelpers 
  
  
  def setup
       @user = User.create!(
         :email => 'testuser@demomailtest.com',
         :password => 'MyTestingPassword',
         :password_confirmation => 'MyTestingPassword'
       )
       sign_in @user
      
  end
  
  
  
end
