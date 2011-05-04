class Page < ActiveRecord::Base
  validates :name, :uniqueness => true, :presence => true

  def screen_name
    self.title || self.name
  end

end
