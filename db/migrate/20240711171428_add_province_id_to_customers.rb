class AddProvinceIdToCustomers < ActiveRecord::Migration[7.1]
  def change
    add_column :customers, :province_id, :integer
  end
end
