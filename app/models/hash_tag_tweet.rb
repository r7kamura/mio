class HashTagTweet < ActiveRecord::Base
  belongs_to :hash_tag
  belongs_to :tweet

  validates :hash_tag_id, :uniqueness => {:scope => :tweet_id}
end
