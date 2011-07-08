require 'test_helper'

class BackgroundsControllerTest < ActionController::TestCase
 
  def setup
     @user = Factory(:user)
     @request.host = "#{@user.username}.stylejonction.com"
     @portfolio = @user.portfolio
   end
   
   test "should redirect to edit_layout when background of portfolio is not custom" do
     sign_in @user
     @portfolio.background = Factory(:predefined_background)
     @portfolio.save
     
     get :edit
     assert_redirected_to edit_layout_portfolio_path
      
  end
  
   test "should access edit action when background is custom" do
     sign_in @user
     @portfolio.background = Factory(:custom_background, :user => @user)
     @portfolio.save
     
     get :edit
     assert_response :success
     
     
      
  end
end
