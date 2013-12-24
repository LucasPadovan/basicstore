class AddPromotionToLineItems < ActiveRecord::Migration
  def change
    add_column :line_items, :promotion_id, :integer
  end
end
