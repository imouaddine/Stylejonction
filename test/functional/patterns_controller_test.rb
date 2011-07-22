require 'test_helper'

class PatternsControllerTest < ActionController::TestCase
  
  test "should show pattern" do
   
     @pattern = Factory(:pattern)
     get :show, :id => @pattern.id, :format => 'json'
     
     assert_not_nil assigns(:pattern)
     assert_response :success
  end
  
  
end