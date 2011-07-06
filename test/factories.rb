Factory.define :user do |u|
    u.first_name 'John'
    u.last_name  'Doe'
    u.username "user"
    u.password "password"
    u.password_confirmation "password"
    u.email "imad@ecomstrategy.ca"
    u.admin false
    u.association :portfolio
end

Factory.define :portfolio do |p|
    p.sequence(:theme) { |n| n } 
    #p.association :font
    # p.association :background
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

Factory.define :predefined_background do |f|
  f.name "PredefinedBlob"
  f.background "img.jpg"
end

Factory.define :custom_background do |f|
  f.name "CustomBack"
  f.background "img.jpg"
  f.display_mode "original"
  f.association :user
end

Factory.define :pattern_background do |f|
  f.name "PatternBackground"
  f.background "imp.gif"
  f.color "#ccc333"
end

Factory.define :layout do |f|
  f.name "Layout 1"
  f.css_name "portfolio.css"
end
