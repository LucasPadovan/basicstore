class CreateEstadordens < ActiveRecord::Migration
  def change
    create_table :estadordens do |t|
      t.integer :order_id
      t.integer :user_id
      t.string :estado

      t.timestamps
    end
  end
end
