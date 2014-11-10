FactoryGirl.define do
  factory :app do |f|
    sequence(:name) { |i| "App-#{i}" }
    f.profile 'rails_service'
    f.project
  end

  factory :invalid_app, parent: :app do |f|
    f.name nil
  end
end
