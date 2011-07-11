require 'test_helper'

class ProjectsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  def setup
     @user = Factory(:user)
     @request.host = "#{@user.username}.stylejonction.com"
     @portfolio = @user.portfolio
  end

  test "should get index" do
    get :index, :portfolio_id => @portfolio.id
    assert_response :success
  end

  test "should get new when user is authenticated" do
    sign_in @user
    get :new, :portfolio_id => 1
    assert_response :redirect
  end

  test "should destroy project" do
    sign_in @user
    assert_difference('Project.count', -1) do
      delete :destroy, :portfolio_id => @portfolio.id, :id => @portfolio.projects.first
    end
  end

  test "should invite user to project" do
    sign_in @user
    assert_difference("Invitation.count", 1) do
      post :invite, :email => "myemail@email.com", :id => @portfolio.projects.first
    end
  end

end
