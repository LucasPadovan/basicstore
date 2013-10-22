class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :titulo
      t.text :descripcion
      t.string :image_url
      t.integer :cantidad

      t.timestamps
    end
  end
end
