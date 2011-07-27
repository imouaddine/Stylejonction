require 'test_helper'

class GalleriesControllerTest < ActionController::TestCase
  setup do
    @gallery = Factory(:gallery)
  end

 
  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create gallery" do
    assert_difference('Gallery.count') do
      post :create, gallery: @gallery.attributes
    end

    assert_redirected_to edit_portfolio_project_path(assigns(:gallery).project)
  end

  test "should show gallery" do
    get :show, id: @gallery.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @gallery.to_param
    assert_redirected_to edit_portfolio_project_path(@gallery.project)
  end

  test "should update gallery" do
    put :update, id: @gallery.to_param, gallery: @gallery.attributes
    assert_redirected_to edit_portfolio_project_path(assigns(:gallery).project)
  end

  test "should destroy gallery" do
    assert_difference('Gallery.count', -1) do
      delete :destroy, id: @gallery.to_param
    end
    assert_redirected_to edit_portfolio_project_path(assigns(:gallery).project)
  end
end
