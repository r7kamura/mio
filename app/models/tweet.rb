class Tweet < ActiveRecord::Base
  belongs_to :user
  belongs_to :room

  validates :body, :presence => true, :uniqueness => {:scope => :user_id}

  scope :regular_limit, limit(20)
  scope :timeline, order("created_at DESC").limit(20)
  scope :user, lambda {|user| where(:user_id => user.id) }

end
