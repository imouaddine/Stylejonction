# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.delete_all

puts 'SETTING UP DEFAULT USER LOGIN'
user = User.create! :name => 'Imad Mouaddine', :email => 'imad@ecomstrategy.ca', :password => 'admin', :password_confirmation => 'admin'

user.portfolio = Portfolio.create(:layout => 1, :theme => 0)
user.save

puts 'New user created: ' << user.name






