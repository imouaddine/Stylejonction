require 'test_helper'

class CustomBackgroundsControllerTest < ActionController::TestCase
 
  def setup
     @user = Factory(:user)
     @request.host = "#{@user.username}.stylejonction.com"
     @background = Factory(:custom_background, :user => @user)
   end
  
   test "should access edit action" do
     sign_in @user
     
     get :edit, :id => @background.id
     assert_response :success
     assert_not_nil assigns(:background)
  end
  
  test "should access update when authenticated" do
      
      put :update, id: @background.to_param, background: @background.attributes, :format => 'json'
      assert_response 401
      
      sign_in @user
      put :update, id: @background.to_param, background: @background.attributes, :format => 'json'
      assert_response :success
      assert_not_nil assigns(:background)
  end
  
  test "should access create when authenticated" do
      sign_in @user
      
      assert_difference('CustomBackground.count') do
        post :create, background: @background.attributes, :format => 'js'
      end
      
      assert_response :success
      assert_not_nil assigns(:background)
  end
  
  
end
