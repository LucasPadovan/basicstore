class CreateMediopagos < ActiveRecord::Migration
  def change
    create_table :mediopagos do |t|
      t.string :nombre
      t.string :descripcion

      t.timestamps
    end
  end
end
