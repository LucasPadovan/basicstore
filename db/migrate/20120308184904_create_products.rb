class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :titulo
      t.text :descripcion
      t.string :image_url
      t.decimal :precio, :precision =>8, :scale =>2
      t.integer :product_type_id
      t.integer :cantidad

      t.timestamps
    end
  end
end
