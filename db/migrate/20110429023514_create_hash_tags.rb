class CreateHashTags < ActiveRecord::Migration
  def self.up
    create_table :hash_tags do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :hash_tags
  end
end
