class Tweet < ActiveRecord::Base
  belongs_to :user, :counter_cache => true
  belongs_to :room
  has_many :hash_tag_tweets
  has_many :hash_tags, :through => :hash_tag_tweets
  has_many :favorites

  validates :body, :presence => true#, :uniqueness => {:scope => [:user_id, :room_id]}

  scope :regular_limit, limit(20)
  scope :recent, order("created_at DESC")
  scope :timeline, recent.limit(20)
  scope :user, lambda {|user| where(:user_id => user.id) }
  scope :no_room, where("room_id IS NULL")
  scope :search, lambda {|str| where("body like ?", "%#{URI.unescape(str)}%") if str }
  scope :since, lambda {|id| where("id > ?", id) }

end
