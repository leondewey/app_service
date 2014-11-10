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
    person = FactoryGirl.create(:person)
    expect(FactoryGirl.build(:person, email: person.email)).to_not be_valid
  end
end
