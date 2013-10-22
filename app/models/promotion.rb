class Promotion < ActiveRecord::Base
  belongs_to :product

  attr_accessible :color_combo, :description, :end_date, :flat_discount, :percent_discount, :product_id, :start_date, :title
end
