require 'test_helper'

class PortfoliosControllerTest < ActionController::TestCase
  
  include Devise::TestHelpers
  
  def setup
    @user = Factory(:user)
    @request.host = "#{@user.username}.stylejonction.com"
  end
  
  test "should deny access to edit_layout " do
    get :edit_layout
    assert_redirected_to new_user_session_path
  end
  
  test "should deny access to edit_font " do
    get :edit_font
    assert_redirected_to new_user_session_path
  end
  
  test "should deny access to update" do
    post :update 
    assert_redirected_to new_user_session_path
  end
  
  test "should get edit_layout when user is authenticated " do
    sign_in @user
    get :edit_layout
    assert_response :success
  end
  
  test "should get edit_font when user is authenticated " do
     sign_in @user
     get :edit_font
     assert_response :success
   end
   
  test "should update portfolio" do
    sign_in @user
    @user.portfolio.theme = 2
    @user.portfolio.save

    get :update, {:portfolio => {:theme => 10} }
    assert_redirected_to portfolio_path, :notice => 'Portfolio was successfully updated.'
    @user.reload
    assert_equal 10, @user.portfolio.theme
  end

end