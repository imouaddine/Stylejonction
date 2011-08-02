source 'http://rubygems.org'
# Bundle edge Rails instead:
gem 'rails',     :git => 'git://github.com/rails/rails.git', :branch => "3-1-stable"

gem 'sass-rails', "~> 3.1.0.rc"
gem 'coffee-script'
gem 'uglifier'
gem 'jquery-rails'
gem "devise", "= 1.3.3"

gem 'compass', :git =>  'https://github.com/chriseppstein/compass.git', :branch => 'rails31'

gem "active_link_to", "~> 0.0.10"


#backbone
gem "rails-backbone"

#file upload
gem 'rmagick'
gem 'carrierwave'
gem 'fog'

group :development, :test do
  gem 'autotest-rails'
  gem 'autotest'
  gem 'mocha'
  gem 'sqlite3'
  gem "rails-footnotes", ">= 3.7"
  gem "factory_girl"
  gem 'capybara', :git => 'git://github.com/jnicklas/capybara.git'
  gem 'launchy'
  gem 'database_cleaner'
end

group :production do
  gem 'therubyracer-heroku', '0.8.1.pre3'
  gem 'pg'
end
