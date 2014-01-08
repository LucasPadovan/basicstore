class Post < ActiveRecord::Base
  validates :body, :title, presence: true

  attr_accessible :active, :body, :title

  belongs_to :user

  scope :all_active, -> { where(active: true).order('created_at desc') }
end
