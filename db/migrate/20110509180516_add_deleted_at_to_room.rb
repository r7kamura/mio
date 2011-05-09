class AddDeletedAtToRoom < ActiveRecord::Migration
  def self.up
    add_column :rooms, :deleted_at, :datetime
  end

  def self.down
    remove_column :rooms, :deleted_at
  end
end
