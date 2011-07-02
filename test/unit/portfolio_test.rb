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


end
