class CreatePromotions < ActiveRecord::Migration
  def change
    create_table :promotions do |t|
      t.string :title
      t.string :color_combo
      t.float :total
      t.string :state
      t.text :description
      t.datetime :start_date
      t.datetime :end_date

      t.timestamps
    end

    create_table :promotion_lines do |t|
      t.string :discount_type
      t.float :discount
      t.integer :promotion_id
      t.integer :product_id

      t.timestamps
    end

    add_index :promotion_lines, [:promotion_id, :product_id]
  end
end
