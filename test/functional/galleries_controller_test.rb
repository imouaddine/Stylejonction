require 'test_helper'

class GalleriesControllerTest < ActionController::TestCase
  setup do
    @project = Factory(:project)
    @gallery = Factory(:gallery)
    4.times do |i|
      @gallery.videos << Factory(:video)
    end
    4.times do |i|
      @gallery.photos << Factory(:photo)
    end
    @gallery.save
    
    
  end

 
  test "should get new" do
    get :new, :project_id => @project.id
    assert_redirected_to edit_portfolio_project_path(@project.id)+"?new_gallery=1"
  end

  test "should create gallery" do
    assert_difference('Gallery.count') do
      post :create, gallery: @gallery.attributes
    end

    assert_redirected_to edit_portfolio_project_path(assigns(:gallery).project)+"?gallery_id=#{assigns(:gallery).id}"
  end

  test "should show gallery" do
    get :show, id: @gallery.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @gallery.to_param
    assert_redirected_to edit_portfolio_project_path(@gallery.project)+"?gallery_id=#{@gallery.id}"
  end

  test "should update gallery" do
    put :update, :id => @gallery.to_param, :gallery =>{:title =>"OOOPS" } 
    assert_redirected_to edit_portfolio_project_path(assigns(:gallery).project)+"?gallery_id=#{assigns(:gallery).id}"
    assert_equal assigns(:gallery).title, "OOOPS"
  end


  test "should update order of elements of gallery" do
    weight = ''
    @gallery.elements.each_with_index do |element, index|
      weight += "element[]=#{element.id}&"
    end

    put :update, id: @gallery.to_param, gallery_weight: weight
    assert_redirected_to edit_portfolio_project_path(assigns(:gallery).project)+"?gallery_id=#{assigns(:gallery).id}"
    
    #TODO validate weight
    
  end
  test "should destroy gallery" do
    assert_difference('Gallery.count', -1) do
      delete :destroy, id: @gallery.to_param
    end
    
    assert_redirected_to edit_portfolio_project_path(assigns(:gallery).project_id)+"?new_gallery=1"
  end
end
