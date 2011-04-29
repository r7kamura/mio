class Tweet < ActiveRecord::Base
  belongs_to :user
  belongs_to :room
  has_many :hash_tag_tweets
  has_many :hash_tags, :through => :hash_tag_tweets
  has_many :favorites

  validates :body, :presence => true, :uniqueness => {:scope => :user_id}

  scope :regular_limit, limit(20)
  scope :timeline, order("created_at DESC").limit(20)
  scope :user, lambda {|user| where(:user_id => user.id) }
  scope :no_room, where("room_id IS NULL")

end
