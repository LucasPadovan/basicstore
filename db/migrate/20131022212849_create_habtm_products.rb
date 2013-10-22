class CreateHabtmProducts < ActiveRecord::Migration
  def change
    create_table :habtm_products do |t|
      t.integer :product_id
      t.integer :product_type_id
    end
    add_index :habtm_products, [:product_id, :product_type_id]
  end
end
