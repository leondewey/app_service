class Project < ActiveRecord::Base
  has_many :permissions
  has_many :people, through: :permissions

  validates :name, length: { maximum: 64 }, presence: true, uniqueness: true
end
