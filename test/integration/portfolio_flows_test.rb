require 'integration_test_helper'


class PortfolioFlowsTest < ActionDispatch::IntegrationTest
  
  def setup
      @user = loggin
      @portfolio = @user.portfolio
      change_subdomain_to(@user.username)
   end
  
  
  test "supports js" do
      visit portfolio_path
      click_link "test js"

     # This would only work used with RSpec: page.should have_content("js works")
      assert_equal true, page.has_content?("js works")
  end
  
  test "edit_layout portfolio page" do
    visit  edit_layout_portfolio_path
  end
  
  test "edit_font portfolio page" do
    Font.create(:name => 'Times New Roman', :webfont => true)
    f = Font.create(:name => 'Arial', :webfont => true)
    
    visit  edit_font_portfolio_path 
    
    find('#title_font_field').click_link "Arial"
    # You had a typo here, also you have to reload the
    # object if you change it in the db
    @portfolio.reload
    assert_equal f, @portfolio.title_font
  end
end
