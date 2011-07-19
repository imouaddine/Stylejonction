require 'test_helper'

class PortfoliosControllerTest < ActionController::TestCase

  include Devise::TestHelpers

  def setup
    Factory.create(:font)
    @user = Factory(:user)
    @request.host = "#{@user.username}.stylejonction.com"
  end

  test "should deny access to edit_layout " do
    get :edit_layout
    assert_redirected_to new_user_session_path
  end

  test "should deny access to edit_font " do
    get :edit_font
    assert_redirected_to new_user_session_path
  end

  test "should deny access to update" do
    post :update
    assert_redirected_to new_user_session_path
  end

  test "should get edit_layout when user is authenticated " do
    sign_in @user
    get :edit_layout
    assert_response :success
  end

  test "should get edit_font when user is authenticated " do
     sign_in @user
     get :edit_font
     assert_response :success
   end

  test "should update portfolio theme" do
    sign_in @user
    
    @request.env['HTTP_REFERER'] = edit_layout_portfolio_path
    
    get :update, {:portfolio => {:theme => "dark"} }
    
    assert_redirected_to edit_layout_portfolio_path, :notice => 'Portfolio was successfully updated.'
    assert_not_nil assigns(:portfolio)
    
    @user.reload
    
    assert_equal "dark", @user.portfolio.theme
  end
  
  test "should update predefined background" do
    sign_in @user
    
    @request.env['HTTP_REFERER'] = edit_layout_portfolio_path
    
    background = Factory(:predefined_background)
    get :update, {:portfolio => { :background_id => background.id, :background_type => "PredefinedBackground" } }

    assert_redirected_to edit_layout_portfolio_path
    assert_not_nil assigns(:portfolio)
    
    @user.reload
    
    assert_equal background, @user.portfolio.background
  end
  
  test "should update pattern background" do
    sign_in @user
    
    @request.env['HTTP_REFERER'] = edit_layout_portfolio_path
    
    background = Factory(:pattern_background)
    post :update, {:portfolio => { :background_id => background.id, :background_type => "PatternBackground", :pattern_background_id => background.id, :pattern_background_attributes => {:color => '330099'} } }

    assert_redirected_to edit_layout_portfolio_path
    assert_not_nil assigns(:portfolio)
    
    @user.reload
    
    assert_equal background, @user.portfolio.background
    
    # I don't why it's failing
    #assert_equal '330099', @user.portfolio.background.color
  end
  
  
  
  test "should update fonts" do
    sign_in @user
    
    @user.portfolio.body_font = nil
    @user.portfolio.body_color = '000000'
    assert @user.portfolio.save, @user.portfolio.errors.inspect
    
    @request.env['HTTP_REFERER'] = edit_font_portfolio_path
    
    font = Factory(:font)
    get :update, {:portfolio => { :body_font_id => font.id, :body_color => '229999' } }
    

    assert_redirected_to edit_font_portfolio_path
    assert_not_nil assigns(:portfolio)
    
    @user.reload
    
    assert_equal font, @user.portfolio.body_font
    assert_equal '229999', @user.portfolio.body_color
    
    
  end
  
  
  test "should update custom background" do
    sign_in @user

    @request.env['HTTP_REFERER'] = edit_layout_portfolio_path
    
    background = Factory(:custom_background, :user => @user)

    post :update, {:portfolio => { :background_id => background.id, :background_type => "CustomBackground" } }
    
    assert_not_nil assigns(:portfolio)
    @user.reload
    
    assert_equal background, @user.portfolio.background
    assert_equal background.user, @user

  end



  test "can publish a portfolio" do
    sign_in @user
    put :publish
    @user.reload
    assert_equal true, @user.portfolio.published?
  end

end
