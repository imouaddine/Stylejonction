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

      assert_equal true, page.has_content?("js works")
  end
  
  test "edit_layout portfolio page" do
    background = Factory( :predefined_background )
    
    visit  edit_layout_portfolio_path
 
    find(".image_link[@data-id='#{background.id}']").click
    
    @portfolio.reload
    assert_equal background, @portfolio.background
    
  end
  
  test "update display mode of custom background" do
    @portfolio.background = Factory( :custom_background, :user => @user )
    assert_equal @portfolio.save, true
    @portfolio.reload
    visit  edit_layout_portfolio_path
    
    
    find("#upload_custom_bg_links .edit_link").click
    find("#edit_own_background input[@value='tile']").click
    @portfolio.background.reload
    
    assert_equal @portfolio.background.display_mode, "tile"
  end
  
  test "edit_font portfolio page" do
    Font.create(:name => 'Times New Roman', :webfont => true)
    f = Font.create(:name => 'Arial', :webfont => true)
    
    visit  edit_font_portfolio_path 
    
    find('#title_font_field').click_link "Arial"
    @portfolio.reload
    assert_equal f, @portfolio.title_font
  end
  
  
  
end
