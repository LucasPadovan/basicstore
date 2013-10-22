class HabtmProduct < ActiveRecord::Base
  belongs_to :product
  belongs_to :product_type
end
