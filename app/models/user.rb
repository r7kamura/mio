class User < ActiveRecord::Base
  has_many :tweets

  validates :screen_name, :presence => true, :uniqueness => true
  validates :email, :presence => true, :uniqueness => true#, :email_format => true

  def tweet(body)
    t = Tweet.new(:body => body, :user_id => self.id)
    t.save
  end

  def reply
  end

  def retweet
  end

  def direct_message
  end

  def favorite
  end

  def remove
  end

  def block
  end
end
