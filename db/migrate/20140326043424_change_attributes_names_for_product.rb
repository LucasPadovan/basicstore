class ChangeAttributesNamesForProduct < ActiveRecord::Migration
  def up
    rename_column :products, :titulo, :title
    rename_column :products, :descripcion, :description
    rename_column :products, :cantidad, :quantity
  end

  def down
    rename_column :products, :title, :titulo
    rename_column :products, :description, :descripcion
    rename_column :products, :quantity, :cantidad
  end
end
