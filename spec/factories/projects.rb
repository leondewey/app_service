FactoryGirl.define do
  factory :project do |f|
    sequence(:name) { |i| "Project-#{i}" }
  end

  factory :invalid_project, parent: :project do |f|
    f.name nil
  end
end
