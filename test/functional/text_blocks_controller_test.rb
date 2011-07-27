require 'test_helper'

class TextBlocksControllerTest < ActionController::TestCase
  setup do
    @text_block = Factory(:text_block)
  end

 

  test "should create text_block" do
    assert_difference('TextBlock.count') do
      post :create, text_block: @text_block.attributes
    end
    assert_redirected_to edit_portfolio_project_path(assigns(:text_block).project)
   
  end

  test "should show text_block" do
    get :show, id: @text_block.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @text_block.to_param
    assert_response :success
  end

  test "should update text_block" do
    put :update, id: @text_block.to_param, text_block: @text_block.attributes
    assert_redirected_to edit_portfolio_project_path(assigns(:text_block).project)
  end

  test "should destroy text_block" do
    assert_difference('TextBlock.count', -1) do
      delete :destroy, id: @text_block.to_param
    end

    assert_redirected_to edit_portfolio_project_path(assigns(:text_block).project)
  end
end
