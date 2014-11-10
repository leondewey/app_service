class App < ActiveRecord::Base
  belongs_to :project

  SUPPORTED_APP_PROFILES = %w(rails_service rails_console rails_standalone)

  validates :name, length: { maximum: 25 }, presence: true, uniqueness: true
  validates_inclusion_of :profile, in: SUPPORTED_APP_PROFILES
  validates :project_id, presence: true
end
