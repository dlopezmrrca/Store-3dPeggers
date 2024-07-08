ActiveAdmin.register Product do
  remove_filter :images_attachments, :images_blobs

  permit_params :name, :description, :price, :category_id, images: []

  index do
    selectable_column
    id_column
    column :name
    column :price
    column :created_at
    column :description
    column :category
    column :images do |product|
      ul do
        product.images.each do |img|
          li do
            image_tag url_for(img), size: "50x50"
          end
        end
      end
    end
    actions
  end

  filter :name
  filter :description
  filter :price
  filter :created_at

  form do |f|
    f.inputs do
      f.input :name
      f.input :description
      f.input :price
      f.input :category, as: :select, collection: Category.all.collect { |category| [category.name, category.id] }
      f.input :images, as: :file, input_html: { multiple: true }
    end
    f.actions
  end

  show do |product|
    attributes_table do
      row :name
      row :description
      row :price
      row :created_at
      row :updated_at
      row :category
      row :images do
        ul do
          product.images.each do |img|
            li do
              image_tag url_for(img), size: "100x100"
            end
          end
        end
      end
    end
  end
end
