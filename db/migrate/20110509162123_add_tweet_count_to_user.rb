class AddTweetCountToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :tweets_count, :integer, :default => 0

    # set tweet_count for user who already exists
    User.reset_column_information
    User.all.each do |user|
      user.update_attribute :tweets_count, user.tweets.length
    end
  end

  def self.down
    remove_column :users, :tweets_count
  end
end
