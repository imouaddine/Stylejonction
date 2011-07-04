require 'integration_test_helper'


class PortfolioFlowsTest < ActionDispatch::IntegrationTest
  test "edit_layout portfolio page" do
    loggin
    visit edit_layout_portfolio_path
  end
end
