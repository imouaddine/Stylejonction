require 'test_helper'

class PredefinedBackgroundsControllerTest < ActionController::TestCase
  
  test "should show background" do
   
     @predefined_background = Factory(:predefined_background)
     
     get :show, :id => @predefined_background.id, :format => 'json'
     assert_response :success
     
     
      
  end
  
  
end