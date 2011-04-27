class AddRoomIdToTweet < ActiveRecord::Migration
  def self.up
    add_column :tweets, :room_id, :integer
  end

  def self.down
    remove_column :tweets, :room_id
  end
end
