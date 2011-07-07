require 'test_helper'
 
class PortfolioTest < ActiveSupport::TestCase

  def setup
    @portfolio = Factory :portfolio
  end
  
  test "can create a test object from fg" do
    assert @portfolio.valid?
  end
  
  test "new portoflio is not published" do
    assert ! @portfolio.published?
  end

  test "save body and title font " do
    @font = Factory :font
    @portfolio.body_font = @font
    @portfolio.save
    assert_equal @font, @portfolio.body_font
    
  end
  test "can change portfolio state to published" do
    @portfolio.publish!
    @portfolio.reload
    assert_equal true, @portfolio.published?
  end

  test "can't undo publishing" do
    @portfolio.publish!
    @portfolio.reload
    @portfolio.published = false
    @portfolio.save
    
    assert_equal true, @portfolio.published?
  end

  test "predefined background association works" do
    portfolio = Factory.create(:portfolio)
    background = Factory.create(:predefined_background)
    portfolio.background = background
    portfolio.save
    portfolio.reload
    assert_equal "PredefinedBackground", portfolio.background_type
  end

  test "custom background association works" do
    portfolio = Factory.create(:portfolio)
    background = Factory.create(:custom_background)
    portfolio.background = background
    portfolio.save
    portfolio.reload
    assert_equal "CustomBackground", portfolio.background_type
  end

  test "pattern background association works" do
    portfolio = Factory.create(:portfolio)
    background = Factory.create(:pattern_background)
    portfolio.background = background
    portfolio.save
    portfolio.reload
    assert_equal "PatternBackground", portfolio.background_type
  end


  test "by default portfolio should have " do
    Factory.create(:predefined_background) 
    Layout.create(:name => "left")
    Factory.create(:font) 

    portfolio = Portfolio.create
    portfolio.reload

    assert_equal "PredefinedBackground", portfolio.background_type
    assert_equal "left", portfolio.layout.name
    #assert_equal Theme.find_by_type("light"), portfolio.theme 
    assert_equal Font.first, portfolio.title_font
    assert_equal Font.first, portfolio.body_font
    #assert_equla "#5d5d5d", portfolio.font.color 
  end
end
