require 'rails_helper'

describe App do
  it "has a valid factory" do
    expect(FactoryGirl.create(:app)).to be_valid
  end

  it "is invalid without a name" do
    expect(FactoryGirl.build(:app, name: nil)).to_not be_valid
  end

  it "does not allow duplicate names" do
    app = FactoryGirl.create(:app)
    expect(FactoryGirl.build(:app, name: app.name)).to_not be_valid
  end

  it "must have a project" do
    expect(FactoryGirl.build(:app, project: nil)).to_not be_valid
  end

  it "must have a defined profile type" do
    expect(FactoryGirl.build(:app, profile: 'garbage')).to_not be_valid
  end
end
