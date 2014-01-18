class ChangeMediopagosNames < ActiveRecord::Migration
  def change
    rename_column :mediopagos, :nombre, :name
    rename_column :mediopagos, :descripcion, :description
    rename_table :mediopagos, :payment_methods
  end
end
