class AddFieldsToCustomers < ActiveRecord::Migration[7.1]
  def change
    add_column :customers, :first_name, :string
    add_column :customers, :last_name, :string
    add_column :customers, :address, :string
    add_column :customers, :city, :string
    add_column :customers, :zip_code, :string
    add_column :customers, :country, :string
  end
end
