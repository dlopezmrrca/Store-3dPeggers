# app/admin/categories.rb
ActiveAdmin.register Category do
  permit_params do
    permitted = [:name]
    permitted
  end

  # Paginate the collection before rendering the index view
  controller do
    def scoped_collection
      super.per_page_kaminari(params[:page]).per(10)
    end
  end

  index do
    selectable_column
    id_column
    column :name
    column :created_at
    actions
  end
end
