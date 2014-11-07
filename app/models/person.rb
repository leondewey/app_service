class Person < ActiveRecord::Base
  has_many :permissions

  validates :name, length: { maximum: 128 }, presence: true
  validates :email, length: { maximum: 128 }, presence: true, uniqueness: true
  validates :org, length: { maximum: 30 }

end
