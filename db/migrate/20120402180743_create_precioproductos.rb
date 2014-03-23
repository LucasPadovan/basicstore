class CreatePrecioproductos < ActiveRecord::Migration
  def change
    create_table :precioproductos do |t|
      t.integer :product_id
      t.decimal :costo, precision: 8, scale: 2
      t.decimal :preciopublico, precision: 8, scale: 2
      t.string :detalle
      t.date :validodesde

      t.timestamps
    end
  end
end
