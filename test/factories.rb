FactoryGirl.define do
  factory :user do
    first_name 'John'
    last_name  'Doe'
    username "user1"
    encrypted_password "$2a$10$fDyS55n.lu6mMrFhzBe56.ZMXuA3Ls1jnsVObXK/xkvK..."
    email "imad@ecomstrategy.ca"
    admin false
  end

  Factory.sequence :theme { |n| n }

  factory :portfolio do
    theme Factory.next(:theme) 
    association :user
  end

  Factory.sequence :titles do |n|
    “Project #{n}”
  end

  factory :project do 
    title  Factory.next(:titles)
    association :portfolio
  end 
end
