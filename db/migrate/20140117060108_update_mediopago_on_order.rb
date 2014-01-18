class UpdateMediopagoOnOrder < ActiveRecord::Migration
  def change
    rename_column :orders, :mediopago_id, :payment_method_id
  end
end
