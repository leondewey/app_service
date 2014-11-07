class CreatePermissions < ActiveRecord::Migration
  def change
    create_table :permissions do |t|
      t.references :project, index: true
      t.references :person, index: true
      t.boolean :write, default: false, null: false

      t.timestamps
    end
  end
end
