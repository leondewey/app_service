class AddProfileToApps < ActiveRecord::Migration
  def change
    add_column :apps, :profile, :string
  end
end
