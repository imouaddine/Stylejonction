require 'test_helper'

class PortfolioControllerTest < ActionController::TestCase
  
  include Devise::TestHelpers
  
  fixtures :users, :portfolios
  
  def setup
    
    sign_in @user
    @request.host = "#{@user.subdomain}.example.com"
  end
 
  
  
  test "should get show" do
   
    
    
    get :show
    assert_response :success
  end
  

  
  
end
