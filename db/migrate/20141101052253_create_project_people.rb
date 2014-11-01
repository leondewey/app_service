class CreateProjectPeople < ActiveRecord::Migration
  def change
    create_table :project_people do |t|
      t.references :project, index: true
      t.references :person, index: true

      t.timestamps
    end
  end
end
