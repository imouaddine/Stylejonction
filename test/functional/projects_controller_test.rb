require 'test_helper'

class ProjectsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  def setup
    @user = Factory(:user)
    @request.host = "#{@user.username}.stylejonction.com"
    @portfolio = @user.portfolio
    @project = Factory.create(:project, :portfolio => @portfolio)
  end

  

  test "should get new project when user is authenticated" do
    sign_in @user
    get :new, :portfolio_id => 1
    assert_response :success
    assert_not_nil assigns(:project)
    assert_not_nil assigns(:gallery)
    assert_not_nil assigns(:text_block)
    assert_not_nil assigns(:document_block)
  end
  
  test "should get edit" do
    sign_in @user
    get :edit, id: @project.to_param
    
    assert_response :success
    
    assert_not_nil assigns(:project)
    assert_not_nil assigns(:gallery)
    assert_not_nil assigns(:text_block)
    assert_not_nil assigns(:document_block)
  end
  

  test "should destroy project" do
    sign_in @user

    assert_difference('Project.count', -1) do
      delete :destroy, :portfolio_id => @portfolio.id, :id => @project.id
    end

  end
  test "make first project default after destroying an old default project" do
     sign_in @user

     @project.make_default

     Factory.create(:project, :portfolio => @portfolio)

     assert_difference('Project.count', -1) do
         delete :destroy, :portfolio_id => @portfolio.id, :id => @project.id
     end
     #should be fixed
     #assert @portfolio.projects.first.default?

  end
  test "destroy on project removes all project invitations" do
    sign_in @user
    2.times do |i|
      Invitation.create!(:email => "my#{i}@email.com", :project => @portfolio.projects.first)
    end

    invitation_count = Invitation.count

    assert_difference('Project.count', -1) do
      delete :destroy, :portfolio_id => @portfolio.id, :id => @portfolio.projects.first
    end
    assert_equal (invitation_count - 2), Invitation.count
  end

  test "should invite user to project" do
    sign_in @user
    assert_difference("Invitation.count", 1) do
      post :invite, :email => "myemail@email.com", :id => @portfolio.projects.first
    end
  end

  test "should be able to create new project " do
    sign_in @user
    post :create, :portfolio_id => @portfolio.id, :project => { :title => "This is awesome" }
    assert_equal "This is awesome", Project.last.title
  end

end
