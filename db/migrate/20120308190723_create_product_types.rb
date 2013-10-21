class CreateProductTypes < ActiveRecord::Migration
  def change
    create_table :product_types do |t|
      t.string :name
      t.string :description
      t.integer :position

      t.timestamps
    end
    add_index :product_types, :name
  end
end
