class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :screen_name, :email, :password, :password_confirmation, :remember_me

  has_many :tweets
  has_many :favorites

  validates :screen_name, :presence => true, :uniqueness => true

  def favorite(tweet)
    Favorite.where(:tweet_id => tweet.id, :user_id => self.id).first
  end

end
