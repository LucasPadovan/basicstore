class CreateTipoproductos < ActiveRecord::Migration
  def change
    create_table :tipoproductos do |t|
      t.string :nombre
      t.string :descripcion

      t.timestamps
    end
  end
end
