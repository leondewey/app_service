class CreateApps < ActiveRecord::Migration
  def change
    create_table :apps do |t|
      t.string :name, limit: 25
      t.references :project, index: true
      t.string :repo
      t.string :platform
      t.string :ci
      t.boolean :database, default: false, null: false
      t.text :config

      t.timestamps
    end
    add_index :apps, :name
  end
end
