require 'rails_helper'

describe Project do
  it "has a valid factory" do
    expect(FactoryGirl.create(:project)).to be_valid
  end

  it "is invalid without a name" do
    expect(FactoryGirl.build(:project, name: nil)).to_not be_valid
  end

  it "does not allow duplicate names" do
    project = FactoryGirl.create(:project)
    expect(FactoryGirl.build(:project, name: project.name)).to_not be_valid
  end

  it "can have many people" do
    people = []
    2.times do |i|
      people << FactoryGirl.create(:person)
    end
    expect(FactoryGirl.create(:project, people: people)).to be_valid
  end
end
