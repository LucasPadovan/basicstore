class LineItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :product
  belongs_to :cart

  def total_price
    product.precioproductos.last.preciopublico * quantity
  end

  def total_costo
    product.precioproductos.last.costo * quantity
  end

end
