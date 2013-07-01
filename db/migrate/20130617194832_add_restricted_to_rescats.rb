class AddRestrictedToRescats < ActiveRecord::Migration
  def change
    add_column :rescats, :restricted, :boolean, :default => false
  end
end
