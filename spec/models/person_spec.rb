require 'rails_helper'

describe Person do
  it "has a valid factory" do
    expect(FactoryGirl.create(:person)).to be_valid
  end

  it "is invalid without a name" do
    expect(FactoryGirl.build(:person, name: nil)).to_not be_valid
  end

  it "is invalid without an email" do
    expect(FactoryGirl.build(:person, email: nil)).to_not be_valid
  end

  it "does not allow duplicate emails" do
    expect(FactoryGirl.create(:person, email: 'john@email.com')).to be_valid
    expect(FactoryGirl.build(:person, email: 'john@email.com')).to_not be_valid
  end

  it "can have many projects" do
    projects = []
    2.times do |i|
      projects << FactoryGirl.create(:project)
    end
    expect(FactoryGirl.create(:person, projects: projects)).to be_valid
  end
end
