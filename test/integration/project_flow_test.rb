require 'integration_test_helper'


class ProjectFlowTest < ActionDispatch::IntegrationTest

  def setup
    b = PredefinedBackground.create(:name => "Background sadasdasd")
    b.background.store!(File.open(File.join(Rails.root, "public/assets/images/predefined_backgrounds/2.jpg")))
    b.save!
    Factory.create :font
    @user = loggin
    @portfolio = @user.portfolio
    @portfolio.projects.create(:title => "A title")
    @project = @portfolio.projects.first

    change_subdomain_to(@user.username)
  end

  def teardown
    PredefinedBackground.delete_all
  end

  test "can change projects title" do
    visit edit_portfolio_project_path(@project)
    fill_in "project_title", :with => "This is my title"
    find("#project_title").check("project_default")
    click_button 'Save project'
    @project.reload
    assert_equal "This is my title", @project.title
  end

  test "can make project default" do
    visit edit_portfolio_project_path(@project)
    check("project_default")
    click_button 'Save project'
    @project.reload
    assert_equal true, @project.default?
  end

  test "can make project private" do
    
    visit edit_portfolio_project_path(@project)
    find("#privacy").find("#private_project_btn").click
    click_button 'Save project'
    @project.reload
    assert_equal false, @project.public?
  end

  test "can send invitation" do
    
    @project.update_attribute(:public, false)
    visit edit_portfolio_project_path(@project)
    fill_in "invitation0", :with => "anemail@email.com"
    find("#send_invites").click
    @project.reload
    assert_equal "anemail@email.com", Invitation.last.email
  end

  test "sends invite only once for each email" do
   
    @project.update_attribute(:public, false)

    visit edit_portfolio_project_path(@project)
    before_count = Invitation.count
    fill_in "invitation0", :with => "stacho@email.com"
    fill_in "invitation1", :with => "stacho@email.com"
    find("#send_invites").click
    assert_equal before_count + 1, Invitation.count
  end

  test "can scale to fit project cover" do
    flunk("This is failing because of the changed logic of covers or because of the tabs")
    @project.cover.thumb_format.update_attribute(:scale_to_fit, false)
    visit edit_portfolio_project_path(@project)
    find("#edit_project_cover").click

    check "Scale to fit"

    find("#submit").click

    @project.reload

    assert_equal @project.cover.thumb_format.scale_to_fit, true

  end
  test "can delete project" do

     visit edit_portfolio_project_path(@project)
     assert_difference("Project.count", -1) do
       within "#project_#{@project.id}" do
         page.evaluate_script('window.confirm = function() { return true; }')
         find(".remove_link").click()
       end
      
     end
  end
  





end
