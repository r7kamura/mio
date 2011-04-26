class Tweet < ActiveRecord::Base
  belongs_to :user

  validates_uniqueness_of :body, :scope => [:user_id]

  scope :regular_limit, limit(20)
  scope :user_timeline, lambda {|user_id| where("user_id = ?", user_id) }
  scope :friend_timeline, lambda {|user_id| where("user_id IN (?)", User.find(user_id).follower_ids) }
end
