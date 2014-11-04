FactoryGirl.define do
  factory :person do |f|
    f.name "John Smith"
    sequence(:email) { |i| "email_#{i}@email.com" }
    f.org "Sample Organization"
  end

  factory :invalid_person, parent: :person do |f|
    f.email nil
  end

end
