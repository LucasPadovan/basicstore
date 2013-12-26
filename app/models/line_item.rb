class LineItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :product
  belongs_to :cart
  belongs_to :promotion

  def total_price
    if product_id
      product.actual_public_price * quantity
    else
      promotion.total * quantity
    end
  end

  def total_costo
    cost = ( product_id ? product.actual_cost : promotion.total_cost )
    cost * quantity
  end

end
