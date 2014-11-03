class Project < ActiveRecord::Base
  has_many :project_people
  has_many :people, through: :project_people

  validates :name, length: { maximum: 64 }, presence: true, uniqueness: true
end
