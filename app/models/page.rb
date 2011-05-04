class Page < ActiveRecord::Base
  validate :name, :uniqueness => true, :presence => true

  def screen_name
    self.title || self.name
  end

end
