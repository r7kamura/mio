class Favorite < ActiveRecord::Base
  belongs_to :tweet
  belongs_to :user

  def self.from_tweets(tweets)
    favorites = []
    Favorite.where("tweet_id IN (?)", tweets.map{|t| t.id }).each do |fav|
      favorites[fav.tweet_id] ||= []
      favorites[fav.tweet_id] << fav
    end
    favorites
  end
end
