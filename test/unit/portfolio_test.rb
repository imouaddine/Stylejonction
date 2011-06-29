require 'test_helper'
 
class PortfolioTest < ActiveSupport::TestCase
  
  test "can create a test object from fg" do
    portfolio = Factory(:portfolio)
    assert portfolio.valid?
  end
  
  
end
