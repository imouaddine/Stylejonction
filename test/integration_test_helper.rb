require 'test_helper'
require 'capybara/rails'

module ActionDispatch
  class IntegrationTest
    include Capybara::DSL
  end
end

def loggin
     user = Factory.create(:user)
     visit '/users/sign_in'
     fill_in 'Email', :with => user.email
     fill_in 'Password', :with => user.password
     click_button 'Sign in'
     Capybara.default_host = "http://#{User.last.username}.example.com"
end
