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
    check("project_default")
    @project.reload

    assert_equal "This is my title", @project.title
  end

  test "can make project default" do
    visit edit_portfolio_project_path(@project)
    check("project_default")
    @project.reload

    assert_equal true, @project.default?
  end

  test "can make project private" do
    visit edit_portfolio_project_path(@project)
    find("#private_project_btn").click
    @project.reload

    assert_equal false, @project.public?
  end

  test "can send invitation" do
    visit edit_portfolio_project_path(@project)
    fill_in "invitation0", :with => "anemail@email.com"
    find("#send_invites").click

    @project.reload

    assert_equal "anemail@email.com", Invitation.last.email
  end

  test "sends invite only once for each email" do
    visit edit_portfolio_project_path(@project)
    before_count = Invitation.count
    fill_in "invitation0", :with => "stacho@email.com"
    fill_in "invitation1", :with => "stacho@email.com"
    find("#send_invites").click

    assert_equal before_count + 1, Invitation.count
  end

end
