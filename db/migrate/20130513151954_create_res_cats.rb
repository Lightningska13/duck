class CreateResCats < ActiveRecord::Migration
  def change
    create_table :res_cats do |t|
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
