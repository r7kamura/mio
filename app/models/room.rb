class Room < ActiveRecord::Base
  has_many :tweets
  belongs_to :user

  validates :name, :presence => true, :uniqueness => true
end
