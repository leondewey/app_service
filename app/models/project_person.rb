class ProjectPerson < ActiveRecord::Base
  belongs_to :project
  belongs_to :person

  validates :project, presence: true
  validates :person, presence: true
end
