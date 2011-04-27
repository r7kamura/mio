class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  has_many :tweets

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
