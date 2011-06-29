require 'test_helper'

class ProjectsControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  
  fixtures :users, :portfolios, :projects
  
  def setup
     @user = users(:user1)
     @request.host = "#{@user.username}.stylejonction.com"
     @portfolio = @user.portfolio
  end
  
  test "should get index" do
    get :index, :portfolio_id => @portfolio.id
    assert_response :success
  end
  
  test "should get new when user is authenticated" do
    sign_in @user
    get :new, :portfolio_id => @portfolio.id
    assert_response :success
  end
  
  
   
   
  
  
end