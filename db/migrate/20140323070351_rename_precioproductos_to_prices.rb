class RenamePrecioproductosToPrices < ActiveRecord::Migration
  def up
    rename_table :precioproductos, :prices
    rename_column :prices, :costo, :cost
    rename_column :prices, :preciopublico, :public_price
    rename_column :prices, :detalle, :detail
    rename_column :prices, :validodesde, :valid_since
  end

  def down
    rename_table :prices, :precioproductos
  end
end
