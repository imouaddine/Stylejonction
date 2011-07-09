User.delete_all
Layout.delete_all
PredefinedBackground.delete_all
Portfolio.delete_all
Font.delete_all

puts 'SETTING UP ADMIN LOGIN'
user = User.create!(:username => 'imouaddine',
                    :first_name => 'Imad',
                    :last_name =>'Mouaddine',
                    :email => 'imad@ecomstrategy.ca',
                    :password => 'pass',
                    :password_confirmation => 'pass',
                    :admin => true)

puts "create some backgrounds"
10.times do |i|
  PredefinedBackground.create(:name => "Background #{i}", :background => "#{i}.jpg")
end


puts "create 4 layouts"
Layout.create(:name => "left")
Layout.create(:name => "right")
Layout.create(:name => "top")
Layout.create(:name => "bottom")


puts "Create standard fonts"
Font.create(:name => 'Times New Roman', :webfont => true, :color => "5d5d5d")
Font.create(:name => 'Arial', :webfont => true, :color => "5d5d5d")
Font.create(:name => 'Verdana', :webfont => true, :color => "5d5d5d")
Font.create(:name => 'Georgia', :webfont => true, :color => "5d5d5d")

puts "Create google fonts"
Font.create(
            :name => 'Playfair Display',
            :provider => "Google web fonts",
            :url => 'http://fonts.googleapis.com/css?family=Playfair+Display&v1',
            :color => "5d5d5d"
            )
Font.create(
            :name => 'PT Serif',
            :provider => "Google web fonts",
            :url => 'http://fonts.googleapis.com/css?family=PT+Serif:400,400italic&v2',
            :color => "5d5d5d"
            )
Font.create(
            :name => 'Kameron',
            :provider => "Google web fonts",
            :url => 'http://fonts.googleapis.com/css?family=Kameron&v2',
            :color => "e4e4e4"
            )
Font.create(
            :name => 'Nunito',
            :provider => "Google web fonts",
            :url => 'http://fonts.googleapis.com/css?family=Nunito&v2',
            :color => "e4e4e4"
            )
Font.create(
            :name => 'Dancing Script',
            :provider => "Google web fonts",
            :url => 'http://fonts.googleapis.com/css?family=Dancing+Script&v2',
            :color => "e4e4e4"
            )
Font.create(
            :name => 'Kreon',
            :provider => "Google web fonts",
            :url => 'http://fonts.googleapis.com/css?family=Kreon&v2',
            :color => "e4e4e4"
            )



user.portfolio = Portfolio.create(:theme => "light")
user.portfolio.background = PredefinedBackground.first
user.portfolio.layout = Layout.first
user.portfolio.title_font = Font.first
user.portfolio.body_font = Font.first
user.portfolio.projects.create(:title => 'First Project')
user.portfolio.projects.create(:title => 'Second Project')
user.portfolio.projects.create(:title => 'Third Project')
user.portfolio.projects.create(:title => 'Fourth Project')

user.save

puts 'New user created: ' << user.full_name
