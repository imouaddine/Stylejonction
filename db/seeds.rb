# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.delete_all
Layout.delete_all
Background.delete_all
Portfolio.delete_all
Font.delete_all

puts 'SETTING UP ADMIN LOGIN'
user = User.create! :username => 'imouaddine', :first_name => 'Imad', :last_name =>'Mouaddine', :email => 'imad@ecomstrategy.ca', :password => 'pass', :password_confirmation => 'pass', :admin => true

puts "create some backgrounds"
10.times { Background.create }


puts "create 4 layouts"
Layout.create(:name => "left")
Layout.create(:name => "right")
Layout.create(:name => "top")
Layout.create(:name => "bottom")


puts "Create standard fonts"
Font.create(:name => 'Times New Roman', :webfont => true);
Font.create(:name => 'Arial', :webfont => true);
Font.create(:name => 'Verdana', :webfont => true);
Font.create(:name => 'Georgia', :webfont => true);

puts "Create google fonts"
Font.create(
  :name => 'Playfair Display', 
  :provider => "Google web fonts",
  :url => 'http://fonts.googleapis.com/css?family=Playfair+Display&v1'
);
Font.create(
  :name => 'PT Serif', 
  :provider => "Google web fonts",
  :url => 'http://fonts.googleapis.com/css?family=PT+Serif:400,400italic&v2'
);
Font.create(
  :name => 'Kameron', 
  :provider => "Google web fonts",
  :url => 'http://fonts.googleapis.com/css?family=Kameron&v2'
);
Font.create(
  :name => 'Nunito', 
  :provider => "Google web fonts",
  :url => 'http://fonts.googleapis.com/css?family=Nunito&v2'
);
Font.create(
  :name => 'Dancing Script', 
  :provider => "Google web fonts",
  :url => 'http://fonts.googleapis.com/css?family=Dancing+Script&v2'
);
Font.create(
  :name => 'Kreon', 
  :provider => "Google web fonts",
  :url => 'http://fonts.googleapis.com/css?family=Kreon&v2'
);



user.portfolio = Portfolio.create(:theme => 0)
user.portfolio.background = Background.first
user.portfolio.layout = Layout.first
user.portfolio.font = Font.first
user.portfolio.projects.create(:title => 'First Project')
user.portfolio.projects.create(:title => 'Second Project')
user.portfolio.projects.create(:title => 'Third Project')
user.portfolio.projects.create(:title => 'Fourth Project')

user.save

puts 'New user created: ' << user.full_name









