require 'test_helper'

class PortfolioControllerTest < ActionController::TestCase
  
  include Devise::TestHelpers
  
  fixtures :users, :portfolios
  
  def setup
    @user = users(:user1)
    @request.host = "#{@user.username}.stylejonction.com"
  end
  
  test "should get show" do
    get :show
    assert_response :success
  end
  
  test "should deny access to edit_layout " do
    get :edit_layout, {'id' => @user.portfolio.id}
    assert_redirected_to new_user_session_path
  end
  
  test "should deny access to update" do
    post :update, {'id' => @user.portfolio.id}
    assert_redirected_to new_user_session_path
  end
  
  test "should get edit_layout when user is authenticated " do
    sign_in @user
    get :edit_layout, {'id' => @user.portfolio.id}
    assert_response :success
  end
   
  test "should get update when user is authenticated " do
    sign_in @user
    get :update, {'id' => @user.portfolio.id}
    assert_redirected_to edit_portfolio_path(@portfolio, :notice => 'Portfolio was successfully updated.')
  end
  
end
