class Page < ActiveRecord::Base
  validates :name, :uniqueness => true, :presence => true

  scope :search, lambda {|str|
    where("name like ?", "%#{URI.unescape(str)}%") if str
  }
end
