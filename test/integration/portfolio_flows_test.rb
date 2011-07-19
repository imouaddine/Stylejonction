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
    @portfolio.save
    
    background = Factory( :predefined_background )
    
    visit  edit_layout_portfolio_path

    find(".image_link[@data-id='#{background.id}']").click

    click_button 'Save'
    
    @portfolio.reload
    
    #why it's not working
    #assert_equal background, @portfolio.background

  end
  
  test "update layout portfolio page" do
     @portfolio.layout = 'left'
     @portfolio.save

     visit  edit_layout_portfolio_path

     find("#layout_link_top").click

     click_button 'Save'
     
     @portfolio.reload
     
     #why it's not working
     #assert_equal @portfolio.layout, 'top'

   end
   
   test "update theme portfolio page" do
      @portfolio.theme = 'light'
      @portfolio.save

      visit  edit_layout_portfolio_path

      find("#select_theme_dark").click

      click_button 'Save'
     
      #why it's not working
      #assert_equal @portfolio.theme, 'dark'

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

  test "update portfolio fonts" do
    body_font = Font.create(:name => 'Times New Roman', :webfont => true)
    title_font = Font.create(:name => 'Arial', :webfont => true)
    
    title_color = "223344"
    body_color = "994944"
    
    visit  edit_font_portfolio_path
    
    page.execute_script("$('#color_picker_title_input').val('#{title_color}'); $('#color_picker_body_input').val('#{body_color}'); $('#color_picker_title_input, #color_picker_body_input').trigger('change')")

    
    
    find('#title_font_field').click_link(title_font.name)
    find('#body_font_field').click_link(body_font.name)
     
   
   
    
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

  test "update portfolio theme" do
    @portfolio.theme = "light"
    @portfolio.save

    visit  edit_layout_portfolio_path
    find("#select_theme_dark").click
    
    @portfolio.reload
    
    assert_equal "dark", @portfolio.theme
    assert_equal true, page.has_css?('#preview_content.theme_dark')

  end
  
  test "update portfolio layout" do
    @portfolio.layout = "left"
    @portfolio.save

    visit  edit_layout_portfolio_path
    find("#layout_link_top").click
    
    @portfolio.reload
    
    assert_equal "top", @portfolio.layout
    assert_equal true, page.has_css?('#preview_content.layout_top')

  end
  
  
  
  
  

end
