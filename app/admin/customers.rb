ActiveAdmin.register Customer do
  permit_params :first_name, :last_name, :email, :password, :address, :city, :province_id, :zip_code, :country, :profile_image

  index do
    selectable_column
    id_column
    column :first_name
    column :last_name
    column :email
    column :province
    actions
  end

  filter :first_name
  filter :last_name
  filter :email
  filter :province

  # form do |f|
  #   f.inputs do
  #     f.input :first_name
  #     f.input :last_name
  #     f.input :email
  #     f.input :password
  #     f.input :address
  #     f.input :city
  #     f.input :province
  #     f.input :zip_code
  #     f.input :country
  #     f.input :profile_image
  #   end
  #   f.actions
  # end
end
