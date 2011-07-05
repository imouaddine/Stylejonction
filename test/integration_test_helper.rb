require 'test_helper'
require 'capybara/rails'


module ActionDispatch
  class IntegrationTest
    include Capybara::DSL
  end
end

# This is Jose Valim's hack to make selenium 
# working wit capybara
class ActiveRecord::Base
  mattr_accessor :shared_connection
  @@shared_connection = nil

  def self.connection
    @@shared_connection || retrieve_connection
  end
end

# Forces all threads to share the same connection. This works on
# Capybara because it starts the web server in a thread
ActiveRecord::Base.shared_connection = ActiveRecord::Base.connection


# Becase of the way selenium handles subdomains
# this code is necessary.
# Also you'll have to set this values in your /etc/hosts file:
#  
# 127.0.0.1   user.project.test 
# 127.0.0.1   www.project.test 
# 127.0.0.1   www.user.project.test 
# 127.0.0.1   project.test

Capybara.run_server = true
Capybara.server_port = 9887
PORT = Capybara.server_port



Capybara.app_host = "project.test:#{PORT}"
Capybara.default_driver = :selenium

DOMAIN = "project.test"
 
def change_subdomain_to(subdomain)
    Capybara.app_host = "#{subdomain}.#{DOMAIN}:#{PORT}"
end

def loggin
     user = User.new(:username => "user",
                     :email => "some@example.com",
                     :password => "password",
                     :password_confirmation => "password")
     user.save!

     visit '/users/sign_in'
     fill_in 'Email', :with => user.email
     fill_in 'Password', :with => user.password
     click_button 'Sign in'
     assert_not_nil user.portfolio, 'User portfolio cannot be null'
     user
end
