class Permission < ActiveRecord::Base
  belongs_to :project
  belongs_to :person

  validates :project, presence: true
  validates :person, presence: true
  validates_uniqueness_of :project_id, :scope => :person_id
  validates_inclusion_of :write, in: [true, false]
end
