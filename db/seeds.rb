# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.delete_all

puts 'SETTING UP DEFAULT USER LOGIN'
user = User.create! :username => 'imouaddine', :first_name => 'Imad', :last_name =>'Mouaddine', :email => 'imad@ecomstrategy.ca', :password => 'pass', :password_confirmation => 'pass', :admin => true

user.portfolio = Portfolio.create(:layout => 1, :theme => 0)
user.portfolio.projects.create(:title => 'First Project')
user.portfolio.projects.create(:title => 'Second Project')
user.portfolio.projects.create(:title => 'Third Project')
user.portfolio.projects.create(:title => 'Fourth Project')

user.save



puts 'New user created: ' << user.full_name

puts "Create some fonts"

10.times do |i|
  Font.create(:name => "Font #{i}", 
              :provider => "Google web fonts", 
              :url => "http://google.webfonts.com/#{i}",
              :title => "Title"
             )
end


puts "create some backgrounds"

10.times { Background.create }






