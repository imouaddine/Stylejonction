require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = Factory.create(:user)
  end

  def test_has_a_full_name
    max = User.new(:first_name => "Max",
                   :last_name  => "Pain")

    assert_equal "Max Pain", max.full_name
  end

  def test_has_a_portfolio_after_create
    user = User.new(:first_name => "M", :last_name => "S",
                    :password => "password", :password_confirmation => "password",
                    :email => "thisanemail@gmail.com")
    user.save
    user.reload
    assert user.portfolio.present?
  end

  def test_user_is_not_an_admin_by_default
    user = User.new(:first_name => "M", :last_name => "S",
                    :password => "password", :password_confirmation => "password",
                    :email => "thisanemail@gmail.com")
    assert ! user.admin?, "User shouldn't have admin access"
  end

  def test_user_can_be_given_admin_access
    user = User.new(:first_name => "M", :last_name => "S",
                    :password => "password", :password_confirmation => "password",
                    :email => "thisanemail@gmail.com")
    user.admin = true
    user.save
    user.reload
    assert user.admin?
  end

  def test_portfolio_is_deleted_when_user_is_deleted
    user = Factory.create(:user)
    before_portfolios = Portfolio.count
    user.destroy

    assert_equal before_portfolios - 1, Portfolio.count
  end



  

end
