class LineItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :product
  belongs_to :cart
  belongs_to :promotion

  def total_price
    if product
      product.actual_public_price * quantity
    else
      promotion.total * quantity
    end
  end

  def total_costo
    product.precioproductos.last.costo * quantity
  end

end
