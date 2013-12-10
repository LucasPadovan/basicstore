class Promotion < ActiveRecord::Base

  has_many :promotion_lines

  accepts_nested_attributes_for :promotion_lines, allow_destroy: true

  attr_accessible :color_combo, :end_date, :start_date, :title, :total, :promotion_lines, :description

  validates :title, presence: true

  scope :published, -> { where(state: 'published') }

  def publish
    self.state = 'published'
    self.save
  end

  def unpublish
    self.state = 'not-published'
    self.save
  end

  def published?
    self.state == 'published'
  end
end
