require 'test_helper'

class PortfolioControllerTest < ActionController::TestCase
  
  fixtures :users, :portfolios
  
 
  
  
  test "should get show" do
    get :show
    assert_response :success
  end
  

  
  
end
