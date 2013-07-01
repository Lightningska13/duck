class CreateResources < ActiveRecord::Migration
  def self.up
    create_table :resources do |t|
      t.string :resource_type
      t.string :title
      t.text :description
      t.string :res_file_name
      t.string :res_content_type
      t.integer :res_file_size
      t.boolean :featured
      t.integer :position

      t.timestamps
    end
    
    create_table :rescats do |t|
      t.string :category
      t.text :blurb

      t.timestamps
    end

    create_table :rescats_resources, :id => false do |t|
      t.integer :rescat_id
      t.integer :resource_id
    end
  end

  def self.down
    drop_table :rescats_resources
    drop_table :rescats   
    drop_table :resources
  end
end
