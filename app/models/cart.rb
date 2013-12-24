class Cart < ActiveRecord::Base
  has_many :line_items, dependent: :destroy
  
  def add_product(item)
    current_item = nil
    case item
      when Product
        current_item = line_items.where(product_id: item.id).first
        if current_item
          current_item.quantity += 1
        else
          current_item = line_items.build(product_id: item.id)
        end
      else
        current_item = line_items.where(promotion_id: item.id).first
        if current_item
          current_item.quantity += 1
        else
          current_item = line_items.build(promotion_id: item.id)
        end
    end
    current_item
  end
  
  def total_price
    line_items.to_a.sum {|item| item.total_price}
  end
  
  def total_items
    line_items.sum(:quantity)
  end

end