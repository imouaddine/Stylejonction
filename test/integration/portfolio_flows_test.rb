require 'integration_test_helper'


class PortfolioFlowsTest < ActionDispatch::IntegrationTest
  
  def setup
      @user = loggin
      @portfolio = @user.portfolio
      change_subdomain_to(@user.username)
   end
  
  
  test "supports js" do
      visit portfolio_path(@portfolio)
      click_link "test js"
      page.should have_content("js works")
  end
  
  test "edit_layout portfolio page" do
    
    visit  edit_layout_portfolio_path(@portfolio) 
    
  end
  
  test "edit_font portfolio page" do
    
    assert_not_nil @user.portfolio, 'User portfolio cannot be null'
    
    Font.create(:name => 'Times New Roman', :webfont => true)
    f = Font.create(:name => 'Arial', :webfont => true)
    
    visit  edit_font_portfolio_path(@portfolio) 
    
    find('#title_font_field').click_link "Arial"
    assert_equal f, @porfolio.title_font
  end
end