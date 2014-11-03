FactoryGirl.define do
  factory :person do |f|
    f.name "John Smith"
    sequence(:email) { |i| "email_#{i}@email.com" }
  end
end
