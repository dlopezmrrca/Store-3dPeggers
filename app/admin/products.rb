ActiveAdmin.register Product do

  remove_filter :images_attachments, :images_blobs, :price

  permit_params :name, :description, :price, images: []

end
