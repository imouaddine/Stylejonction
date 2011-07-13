require 'integration_test_helper'


class ProjectTest < ActionDispatch::IntegrationTest

  def setup
    b = PredefinedBackground.create(:name => "Background sadasdasd")
    b.background.store!(File.open(File.join(Rails.root, "public/assets/images/predefined_backgrounds/2.jpg")))
    b.save!
    Factory.create :font
    @user = loggin
    @portfolio = @user.portfolio
    @project = @portfolio.projects.first
    change_subdomain_to(@user.username)
  end

  def teardown
    PredefinedBackground.delete_all
  end

  test "can change projects title" do
    visit edit_portfolio_project_path(@project)
    fill_in "title", :with => "This is my title"
    check("default_project")
    @project.reload

    assert_equal "This is my title", @project.title
  end


end
