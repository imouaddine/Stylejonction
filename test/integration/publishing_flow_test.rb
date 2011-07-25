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
     @portfolio.published = false
     @portfolio.save
      
     visit portfolio_path
     @portfolio.projects << Project.create(:title => "We're publishing something!!")
     click_button "Publish"


     @portfolio.reload

     assert_equal @portfolio.published?, true
   
   end
 end
