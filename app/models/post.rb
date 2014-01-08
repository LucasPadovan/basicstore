class Post < ActiveRecord::Base
  attr_accessible :active, :body, :title

  scope :all_active, -> { where(active: true).order('created_at desc') }
end
