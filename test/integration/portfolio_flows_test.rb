require 'integration_test_helper'


class PortfolioFlowsTest < ActionDispatch::IntegrationTest
  test "edit_layout portfolio page" do
    loggin
    change_subdomain_to(User.last.username)
    Font.create(:name => 'Times New Roman', :webfont => true)
    f = Font.create(:name => 'Arial', :webfont => true)

    click_link "Portfolio"
    click_link "Font"
    click_link "Arial"
    assert_equal f, Portfolio.last.title_font
  end
end
