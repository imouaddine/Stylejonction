Factory.define :user do |u|
  u.first_name 'John'
  u.last_name  'Doe'
  u.username "user"
  u.password "password"
  u.password_confirmation "password"
  u.sequence(:email) { |n| "imad#{n}@ecomstrategy.ca" }
  u.admin false
end

Factory.define :portfolio do |p|
  p.association :user
  p.theme "light"
  p.layout "left"
  p.published false
end

Factory.define :project do |p|
  p.sequence(:title) { |n| "Title #{n}" }
  p.association :portfolio
  p.association :cover, :factory => :image
  p.default false
end

Factory.define :font do |f|
  f.name "Inconsolata"
  f.provider "Google"
  f.url "http://google.webfonts.com"
  f.visible true
end

Factory.define :predefined_background do |f|
  f.name "PredefinedBlob"
  f.background "imp.gif"
end

Factory.define :pattern do |f|
  f.pattern "imp.gif"
end

Factory.define :custom_background do |f|
  f.name "CustomBack"
  f.background "img.jpg"
  f.display_mode "original"
  f.association :user
end

Factory.define :pattern_background do |f|
  f.name "PatternBackground"
  f.association :pattern
  f.color "#ccc333"
end

Factory.define :image do |p|
end

Factory.define :document_block do |f|
  f.title "Document Block"
  f.association :project
end

Factory.define :gallery do |f|
  f.title "Gallery 1"
  f.association :project
end

Factory.define :text_block do |t|
  t.title "Title of the block"
  t.body  "Lorem Ipsum "
  t.association :project
end
