Factory.define :user do |u|
    u.first_name 'John'
    u.last_name  'Doe'
    u.username "user1"
    u.password "password"
    u.password_confirmation "password"
    u.email "imad@ecomstrategy.ca"
    u.admin false
    u.association :portfolio
end

Factory.define :portfolio do |p|
    p.sequence(:theme) { |n| n } 
    #p.association :font
    p.association :background
end


Factory.define :project do |p|
  p.sequence(:title) { |n| "Title #{n}" }
  p.association :portfolio
end 

Factory.define :font do |f|
  f.name "Inconsolata"
  f.provider "Google"
  f.url "http://google.webfonts.com"
  f.visible true
end


Factory.define :background do |f|
  f.display_mode_id 1
  f.color_id 1
  f.pattern_id 1
end

Factory.define :layout do |f|
  f.name "Layout 1"
  f.css_name "portfolio.css"
end
