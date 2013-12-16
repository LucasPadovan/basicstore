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
      self.quantity * self.product.actual_public_price * (100 - self.discount) / 100
    else
      self.quantity * (self.product.actual_public_price - self.discount)
    end
  end

  def percent?
    self.discount_type == '%'
  end
end