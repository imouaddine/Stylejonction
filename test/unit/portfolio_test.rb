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

  test "polymorphic association works" do
    portfolio = Factory.create(:portfolio)
    background = Factory.create(:predefined_background)
    portfolio.background = background
    portfolio.save
    portfolio.reload
    assert_equal "PredefinedBackground", portfolio.background_type
  end


end
