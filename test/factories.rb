Factory.define :user do |u|
    u.first_name 'John'
    u.last_name  'Doe'
    u.username "user1"
    u.password "password"
    u.encrypted_password "$2a$10$fDyS55n.lu6mMrFhzBe56.ZMXuA3Ls1jnsVObXK/xkvK..."
    u.email "imad@ecomstrategy.ca"
    u.admin false
    u.association :portfolio
end

Factory.define :portfolio do |p|
    p.sequence(:theme) { |n| n } 
    p.font 10
end


Factory.define :project do |p|
  p.sequence(:title) { |n| "Title #{n}" }
  p.association :portfolio
end 
