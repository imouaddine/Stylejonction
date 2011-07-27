# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.delete_all
PredefinedBackground.delete_all
PatternBackground.delete_all
CustomBackground.delete_all
Portfolio.delete_all
Font.delete_all
Project.delete_all
Pattern.delete_all



puts "create some predefined backgrounds"
10.times do |i|
  b = PredefinedBackground.create(:name => "Background #{i}")
  b.background.store!(File.open(File.join(Rails.root, "public/assets/images/predefined_backgrounds/#{i}.jpg")))
  b.save!
end

puts "create some pattern background"
7.times do |i|
  p = Pattern.create
  p.pattern.store!(File.open(File.join(Rails.root, "public/assets/images/pattern_backgrounds/#{i}.png")))
  p.pattern.recreate_versions!
  p.save!
end



puts "Create standard fonts"
Font.create(
  :name => 'Times New Roman',
  :webfont => true, 
  :title_font => true, 
  :body_font => true
);
Font.create(
  :name => 'Arial', 
  :webfont => true, 
  :title_font => true, 
  :body_font => true, 
  :title_suggested => true, 
  :body_suggested => true
);
Font.create(:name => 'Verdana', :webfont => true, :title_font => true, :body_font => true);
Font.create(:name => 'Georgia', :webfont => true, :title_font => true, :body_font => true);

puts "Create google fonts"
Font.create(
  :name => 'Playfair Display',
  :provider => "Google web fonts",
  :url => 'http://fonts.googleapis.com/css?family=Playfair+Display&v1',
  :title_font => true, 
  :body_font => true
);
Font.create(
  :name => 'Serif6 Beta',
  :provider => "Google web fonts",
  :url => 'http://fonts.googleapis.com/css?family=PT+Serif:400,400italic&v2',
  :title_font => true, 
  :body_font => true
);
Font.create(
  :name => 'Kameron',
  :provider => "Google web fonts",
  :url => 'http://fonts.googleapis.com/css?family=Kameron&v2',
  :title_font => true, 
  :body_font => true
);

Font.create(
  :name => 'Dancing Script',
  :provider => "Google web fonts",
  :url => 'http://fonts.googleapis.com/css?family=Dancing+Script&v2',
  :title_font => true, 
  :body_font => false
);
Font.create(
  :name => 'NIXIE ONE',
  :provider => "Google web fonts",
  :url => 'http://fonts.googleapis.com/css?family=Nixie+One&v2',
  :title_font => true, 
  :body_font => false
);
#Junction :title_font => true, :body_font => true
#League Gothic :title_font => true, :body_font => false
#Fallend Display :title_font => true, :body_font => false
#Quicksand :title_font => true, :body_font => false
#PT Sans Narrow  :title_font => false, :body_font => true, :body_suggested => true
Font.create(
  :name => 'Nunito',
  :provider => "Google web fonts",
  :url => 'http://fonts.googleapis.com/css?family=Nunito&v2',
  :title_font => true,
  :body_font => true
);
Font.create(
  :name => 'Lato',
  :provider => "Google web fonts",
  :url => 'http://fonts.googleapis.com/css?family=Lato&v2',
  :title_font => true,
  :body_font => true
  
);
Font.create(
  :name => 'Metrophobic',
  :provider => "Google web fonts",
  :url => 'http://fonts.googleapis.com/css?family=Metrophobic&v2',
  :title_font => true,
  :body_font => true
);






puts 'CREATE ADMIN LOGIN'

user = User.create! :username => 'imouaddine', :first_name => 'Imad', :last_name =>'Mouaddine', :email => 'imad@ecomstrategy.ca', :password => 'pass', :password_confirmation => 'pass', :admin => true

puts "Create portfolio project"

4.times do |i|
  project = user.portfolio.projects.new(:title => "Project #{i}", :cover => Image.new)
  project.cover.image.store!(File.open(File.join(Rails.root, "public/assets/images/projects/#{i}.jpg")))
  project.cover.image.recreate_versions!
  project.cover.save
  project.save
  puts "project saved #{project.cover.thumb_url}"
  
end


user.save
user.portfolio.publish!

puts 'New user created: ' << user.full_name
