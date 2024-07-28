ActiveAdmin.register Order do
  permit_params :stripe_payment_id, :customer_id
  remove_filter :total_price, :order_items # Removing unnecessary filters

  filter :customer, collection: proc { Customer.all.map { |customer| [customer.email, customer.id] } }
  filter :created_at
  filter :updated_at

  index do
    selectable_column
    id_column
    column :customer
    column :created_at
    column :updated_at
    actions
  end

  show do
    attributes_table do
      row :customer
      row :created_at
      row :updated_at
    end

    panel "Order Items" do
      table_for order.order_items do
        column :product
        column :quantity
        column :price do |item|
          number_to_currency item.price
        end
        column :total_price do |item|
          number_to_currency item.price * item.quantity
        end
      end
    end

    panel "Total Amount Paid" do
      total_price = order.order_items.sum { |item| item.price * item.quantity }
      customer_province = order.customer.province
      gst = order.order_items.sum { |item| item.price * item.quantity * customer_province.gst_rate }
      pst = order.order_items.sum { |item| item.price * item.quantity * customer_province.pst_rate }
      hst = order.order_items.sum { |item| item.price * item.quantity * customer_province.hst_rate }
      qst = order.order_items.sum { |item| item.price * item.quantity * customer_province.qst_rate }
      grand_total = total_price + gst + pst + hst + qst

      attributes_table_for order do
        row :subtotal do
          number_to_currency total_price
        end
        row :total_gst do
          number_to_currency gst
        end
        row :total_pst do
          number_to_currency pst
        end
        row :total_hst do
          number_to_currency hst
        end
        row :total_qst do
          number_to_currency qst
        end
        row :grand_total do
          number_to_currency grand_total
        end
      end
    end
  end

  form do |f|
    f.inputs do
      f.input :customer, as: :select, collection: Customer.all.map { |customer| [customer.email, customer.id] }
      f.input :stripe_payment_id
    end
    f.actions
  end
end
