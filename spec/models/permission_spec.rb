require 'rails_helper'

describe Permission do
  it "has a valid factory" do
    expect(FactoryGirl.create(:permission)).to be_valid
  end

  it "is invalid without specifying a person" do
    expect(FactoryGirl.build(:permission, person_id: nil)).to_not be_valid
  end

  it "is invalid without specifying a project" do
    expect(FactoryGirl.build(:permission, project_id: nil)).to_not be_valid
  end

  it "is invalid without specifying access level" do
    expect(FactoryGirl.build(:permission, write: nil)).to_not be_valid
  end

  it "is unique for person + project combination" do
    permission = FactoryGirl.create(:permission)
    expect(FactoryGirl.build(:permission, person: permission.person, project: permission.project)).to_not be_valid
  end
end
