class CreateStorages < ActiveRecord::Migration
  def self.up
    create_table :storages do |t|
      t.string :item_file_name
      t.string :item_content_type
      t.integer :item_file_size
      t.datetime :item_updated_at

      t.timestamps
    end
  end

  def self.down
    drop_table :storages
  end
end
