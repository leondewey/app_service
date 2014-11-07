FactoryGirl.define do
  factory :permission do |f|
    f.association :person
    f.association :project
    f.write false
  end

  factory :permission_ro, parent: :permission do |f|
    f.write false
  end

  factory :permission_rw, parent: :permission do |f|
    f.write true
  end

  factory :invalid_permission, parent: :permission do |f|
    f.write nil
  end

end
