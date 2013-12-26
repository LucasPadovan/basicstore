class PromotionLine < ActiveRecord::Base
  belongs_to :product
  belongs_to :promotion

  attr_accessible :product_id, :promotion_id, :discount, :discount_type, :quantity

  validates :discount, :discount_type, :quantity, presence: true

  def to_s
    "-#{discount}#{discount_type}"
  end

  def total
    if percent?
      quantity * product.actual_public_price * (100 - discount) / 100
    else
      quantity * (product.actual_public_price - discount)
    end
  end

  def cost
    quantity * product.actual_cost
  end

  def percent?
    discount_type == '%'
  end
end