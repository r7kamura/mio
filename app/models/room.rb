class Room < ActiveRecord::Base
  has_many :tweets
  belongs_to :user

  validates :name, :presence => true, :uniqueness => {:scope => [:deleted_at]}

  default_scope where("deleted_at IS NULL")
  scope :deleted, unscoped.where("deleted_at IS NOT NULL")

end
