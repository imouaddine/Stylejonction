 require 'integration_test_helper'


 class PublishingFlowsTest < ActionDispatch::IntegrationTest

   def setup
     b = PredefinedBackground.create(:name => "Background sadasdasd")
     b.background.store!(File.open(File.join(Rails.root, "public/assets/images/predefined_backgrounds/2.jpg")))
     b.save!
     Factory.create :font
     @user = loggin
     @portfolio = @user.portfolio
     change_subdomain_to(@user.username)
   end

   test "publishing works" do
     visit portfolio_path
     @portfolio.projects << Project.create(:title => "We're publishing something!!")
     click_button "Publish"


     @portfolio.reload

     assert_equal @portfolio.published?, true
     assert_equal @portfolio.published_projects.count, 1
     assert_equal @portfolio.projects.count, 1
     assert_equal( @portfolio.projects.first.project_copy,
                   @portfolio.published_projects.first)
     assert_equal( @portfolio.published_projects.first.cover,
                   @portfolio.projects.first.cover.cover_copy)
   end
 end
