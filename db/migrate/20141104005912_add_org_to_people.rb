class AddOrgToPeople < ActiveRecord::Migration
  def change
    add_column :people, :org, :string, limit: 30
  end
end
