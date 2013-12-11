class PromotionLine < ActiveRecord::Base
  belongs_to :product
  belongs_to :promotion

  attr_accessible :product_id, :promotion_id, :discount, :discount_type, :quantity

  validates :discount, :discount_type, :quantity, presence: true

  def to_s
    "-#{discount}#{discount_type}"
  end

  def total
    #todo: precio del producto mas accesible
    if percent?
      self.quantity * self.product.precioproductos.last.preciopublico * (100 - self.discount) / 100
    else
      self.quantity * (self.product.precioproductos.last.preciopublico - self.discount)
    end
  end

  def percent?
    self.discount_type == '%'
  end
end