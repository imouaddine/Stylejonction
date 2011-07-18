require 'test_helper'

class PublicPortfoliosControllerTest < ActionController::TestCase

  def setup
    @user = Factory.create(:user)
    @portfolio = @user.portfolio
  end

  test "should be able to see the portfolio if it's published" do
    @portfolio.update_attribute(:published, true)

    get :show, :id => @portfolio.id
    assert_response :success
    assert_equal assigns[:portfolio], @portfolio
  end

  test "should be redirected to home page if portfolio isn't public" do
    @portfolio.update_attribute(:published, false)

    get :show, :id => @portfolio.id
    assert_response :redirect
  end

end
