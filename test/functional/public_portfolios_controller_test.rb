require 'test_helper'

class PublicPortfoliosControllerTest < ActionController::TestCase

  def setup
    @user = Factory.create(:user)
    @portfolio = @user.portfolio
  end

  test "should be able to see the portfolio if it's published" do
    get :show, :id => @portfolio.id
    assert_response :success
    assert_equal assigns[:portfolio], @portfolio
  end

end
