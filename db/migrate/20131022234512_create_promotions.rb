class CreatePromotions < ActiveRecord::Migration
  def change
    create_table :promotions do |t|
      t.integer :product_id
      t.string :title
      t.text :description
      t.string :color_combo
      t.float :flat_discount
      t.float :percent_discount
      t.datetime :start_date
      t.datetime :end_date

      t.timestamps
    end
  end
end
