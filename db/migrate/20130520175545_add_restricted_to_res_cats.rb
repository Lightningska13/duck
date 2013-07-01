class AddRestrictedToResCats < ActiveRecord::Migration
  def change
    add_column :res_cats, :restricted, :boolean
  end
end
