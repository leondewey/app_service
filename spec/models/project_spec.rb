require 'rails_helper'

describe Project do
  it "has a valid factory" do
    expect(FactoryGirl.create(:project)).to be_valid
  end

  it "is invalid without a name" do
    expect(FactoryGirl.build(:project, name: nil)).to_not be_valid
  end

  it "does not allow duplicate names" do
    expect(FactoryGirl.create(:project, name: 'Unique Project')).to be_valid
    expect(FactoryGirl.build(:project, name: 'Unique Project')).to_not be_valid
  end

  it "can have many people" do
    people = []
    2.times do |i|
      people << FactoryGirl.create(:person)
    end
    expect(FactoryGirl.create(:project, people: people)).to be_valid
  end
end
