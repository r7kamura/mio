class Follow < ActiveRecord::Base
  validates_uniqueness_of :to_user_id, :scope => [:from_user_id]
end
