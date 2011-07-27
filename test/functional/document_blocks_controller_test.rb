require 'test_helper'

class DocumentBlocksControllerTest < ActionController::TestCase
  setup do
    @document_block = Factory(:document_block)
  end

 

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create document_block" do
    assert_difference('DocumentBlock.count') do
      post :create, document_block: @document_block.attributes
    end

    assert_redirected_to edit_portfolio_project_path(assigns(:document_block).project)
  end

  test "should show document_block" do
    get :show, id: @document_block.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @document_block.to_param
    assert_response :success
  end

  test "should update document_block" do
    put :update, id: @document_block.to_param, document_block: @document_block.attributes
    assert_redirected_to edit_portfolio_project_path(assigns(:document_block).project)
  end

  test "should destroy document_block" do
    assert_difference('DocumentBlock.count', -1) do
      delete :destroy, id: @document_block.to_param
    end

    assert_redirected_to edit_portfolio_project_path(assigns(:document_block).project)
  end
end
