class Promotion < ActiveRecord::Base

  AVAILABLE_COLORS = [['Amarillo', 'yellow'], ['Azul', 'blue'], ['Negro', 'black'] , ['Rojo', 'red'], ['Verde', 'green']]

  has_many :promotion_lines

  accepts_nested_attributes_for :promotion_lines, allow_destroy: true

  attr_accessible :color_combo, :end_date, :start_date, :title, :total, :promotion_lines, :description

  validates :title, :color_combo, presence: true

  scope :published, -> { where(state: 'published') }

  def to_s
    title
  end

  #states
  def publish
    self.state = 'published'
    self.save
  end

  def unpublish
    self.state = 'not-published'
    self.save
  end

  def published?
    state == 'published'
  end

  #pricing
  def total_cost
    promotion_lines.sum(&:cost)
  end

  def total_price
    promotion_lines.sum(&:total)
  end
end
