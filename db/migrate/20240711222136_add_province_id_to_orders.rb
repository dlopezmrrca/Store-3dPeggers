class AddProvinceIdToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :province_id, :integer
    add_foreign_key :orders, :provinces
  end
end
