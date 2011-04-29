class CreateHashTagTweets < ActiveRecord::Migration
  def self.up
    create_table :hash_tag_tweets do |t|
      t.integer :hash_tag_id
      t.integer :tweet_id

      t.timestamps
    end
  end

  def self.down
    drop_table :hash_tag_tweets
  end
end
