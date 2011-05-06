class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :screen_name, :email, :password, :password_confirmation, :remember_me

  has_many :tweets
  has_many :favorites

  validates :screen_name, :presence => true, :uniqueness => true, :format => {:with => /^\w+$/}

  def favorite(tweet)
    Favorite.where(:tweet_id => tweet.id, :user_id => self.id).first
  end

  def self.from_tweets(tweets)
    users = User.where("id IN (?)", tweets.map{|tweet| tweet.user_id }.uniq)
    users_map = []
    tweets.each do |tweet|
      users_map[tweet.id] ||= users.detect{|user| user.id == tweet.user_id }
    end
    users_map
  end

  def self.from_rooms(rooms)
    users = User.where("id IN (?)", rooms.map{|room| room.user_id }.uniq)
    users_map = []
    rooms.each do |room|
      users_map[room.id] ||= users.detect{|user| user.id == room.user_id }
    end
    users_map
  end
end
