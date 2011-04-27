class Room < ActiveRecord::Base
  has_many :tweets

  validates :name, :presence => true, :uniqueness => true
end
