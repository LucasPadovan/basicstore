class PromotionLine < ActiveRecord::Base
  belongs_to :product
  belongs_to :promotion

  attr_accessible :product_id, :promotion_id, :discount, :discount_type, :quantity
end