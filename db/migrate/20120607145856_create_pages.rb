class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :parent
      t.string :title
      t.text :description
      t.string :pagepic_file_name
      t.integer :pagepic_file_size
      t.string :pagepic_content_type
      t.boolean :published

      t.timestamps
    end
  end
end
