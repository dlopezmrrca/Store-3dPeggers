ActiveAdmin.register Customer do
  permit_params :first_name, :last_name, :email, :password, :address, :city, :province_id, :zip_code, :country

  index do
    selectable_column
    id_column
    column :first_name
    column :last_name
    column :email
    column("Province") { |customer| customer.province.province_name if customer.province }
    actions
  end

  filter :email
  filter :province, as: :select, collection: Province.all.collect { |p| [p.province_name, p.id] }

  form do |f|
    f.inputs do
      f.input :first_name
      f.input :last_name
      f.input :email
      f.input :password
      f.input :address
      f.input :city
      f.input :province, as: :select, collection: Province.all.collect { |p| [p.province_name, p.id] }
      f.input :zip_code
      # f.input :country
      # f.input :profile_image
    end
    f.actions
  end

  show do
    attributes_table do
      row :first_name
      row :last_name
      row :email
      row :address
      row :city
      row("Province") { |customer| customer.province.province_name if customer.province }
      row :zip_code
      # row :country
      # row :profile_image
      row :created_at
      row :updated_at
    end
  end
end
