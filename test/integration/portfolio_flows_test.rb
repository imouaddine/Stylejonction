 require 'integration_test_helper'


 class PortfolioFlowsTest < ActionDispatch::IntegrationTest

   def setup
     b = PredefinedBackground.create(:name => "Background sadasdasd")
    b.background.store!(File.open(File.join(Rails.root, "public/assets/images/predefined_backgrounds/2.jpg")))
    b.save!
    Factory.create :font
    @user = loggin
    @portfolio = @user.portfolio
    change_subdomain_to(@user.username)
  end

  def teardown
    PredefinedBackground.delete_all
  end


  test "supports js" do
    visit portfolio_path
    click_link "test js"

    assert_equal true, page.has_content?("js works")
  end

  test "edit_layout portfolio page" do
    
    @portfolio.background = Factory (:pattern_background)
    assert @portfolio.save, @portfolio.errors.inspect
    
    background = Factory( :predefined_background )
    
    visit  edit_layout_portfolio_path

    find(".image_link[@data-id='#{background.id}']").click

    click_button 'Save portfolio'
    
    @portfolio.reload
    
    assert_equal background, @portfolio.background

  end
  
  test "update layout portfolio page" do
     @portfolio.layout = 'left'
     @portfolio.save

     visit  edit_layout_portfolio_path

     find("#layout_link_top").click

     click_button 'Save portfolio'
     
     @portfolio.reload
     
     assert_equal @portfolio.layout, 'top'

   end
   
   test "update portfolio theme" do
     @portfolio.theme = "light"
     @portfolio.save

     visit  edit_layout_portfolio_path

     click_link "DARK"

     assert_equal true, page.has_css?('#preview_content.theme_dark')

     click_button 'Save portfolio'

     @portfolio.reload

     
     assert_equal @portfolio.theme, "dark"

   end
   

  test "update display mode of custom background" do
    @portfolio.background = Factory( :custom_background, :user => @user )
    assert @portfolio.save, @portfolio.errors.inspect
   
    visit  edit_layout_portfolio_path

    choose('Upload your image')
  
    find("#upload_custom_bg_links .edit_link").click
    
    within("#edit_own_background") do
      choose('Tile')
      click_button 'Save'
    end
   
    click_button 'Save portfolio'
    
    @portfolio.reload
    
    assert_equal "tile", @portfolio.background.display_mode
  end
  test "update portfolio pattern background" do
    background = Factory (:pattern_background)
    @portfolio.pattern_background = background
    @portfolio.save
    
    pattern = Factory (:pattern)
    
    visit  edit_layout_portfolio_path
    choose('Upload your image')
    
    choose('Choose a colour & pattern')
    
    find("#pattern_btn").click
    
    within("#pattern_dialog") do
      find(".pattern_link[@data-id='#{pattern.id}']").click
    end
    
    find("#pattern_btn").click
    
    
    click_button 'Save portfolio'
    
    @portfolio.reload
    
    assert_equal background, @portfolio.background
    assert_equal pattern, @portfolio.background.pattern
    
    
    
  end
  test "update portfolio fonts" do
    body_font = Font.create(:name => 'Times New Roman', :webfont => true)
    title_font = Font.create(:name => 'Arial', :webfont => true)
    
    title_color = "223344"
    body_color = "994944"
    
    visit  edit_font_portfolio_path
    
    page.execute_script("$('#portfolio_title_color').val('#{title_color}'); $('#portfolio_body_color').val('#{body_color}');")

    
    
    find('#title_font_field').click_link(title_font.name)
    find('#body_font_field').click_link(body_font.name)
     
   
    click_button 'Save portfolio'
    
    @portfolio.reload
    
    assert_equal title_font, @portfolio.title_font
    assert_equal title_color, @portfolio.title_color
    
    assert_equal body_font, @portfolio.body_font
    assert_equal body_color, @portfolio.body_color
    
    
    #It doesn't work as expected
    #within("#preview_content") do
      #assert_equal true, page.has_content?(title_font.name)
      #assert_equal true, page.has_content?(body_font.name)
    #end
    
    
  end


  
  test "update portfolio layout" do
    @portfolio.layout = "left"
    @portfolio.save

    visit  edit_layout_portfolio_path
    find("#layout_link_top").click
    
    assert_equal true, page.has_css?('#preview_content.layout_top')
    
    click_button 'Save portfolio'
    
    @portfolio.reload
    
    
    assert_equal "top", @portfolio.layout
    

  end
  
 
  
  
  

end
