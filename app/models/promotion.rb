class Promotion < ActiveRecord::Base

  has_many :promotion_lines

  accepts_nested_attributes_for :promotion_lines, allow_destroy: true

  attr_accessible :color_combo, :end_date, :start_date, :title, :total, :state, :promotion_lines, :description

  validates :title, presence: true
end
