class CartsController < ApplicationController
  before_action :set_product, only: [:create, :destroy]
  before_action :set_province, only: [:show, :checkout, :stripe_session, :success]
  before_action :set_current_customer

  def create
    @cart_item = @current_cart.cart_items.find_by(product_id: @product.id)
    if @cart_item
      @cart_item.increment!(:quantity)
    else
      @current_cart.cart_items.create(product_id: @product.id, quantity: params[:quantity] || 1)
    end
  end

  def show
    @total_quantity = @current_cart.cart_items.sum(:quantity)
    @total_price = calculate_total_price_with_taxes(@current_cart.cart_items, @province)
  end

  def checkout
    @total_price = calculate_total_price_with_taxes(@current_cart.cart_items, @province)
  end

  def destroy
    @cart_item = @current_cart.cart_items.find_by(product_id: @product.id)
    @cart_item.destroy
    redirect_to cart_path(@current_cart)
  end

  def stripe_session
    total_price_with_taxes = calculate_total_price_with_taxes(@current_cart.cart_items, @province)

    session = Stripe::Checkout::Session.create({
      ui_mode: 'embedded',
      line_items: @current_cart.cart_items.map do |item|
        {
          price_data: {
            currency: "usd",
            unit_amount: (calculate_unit_price_with_taxes(item) * 100).to_i,
            product_data: {
              name: item.product.name
            },
          },
          quantity: item.quantity,
        }
      end,
      mode: 'payment',
      return_url: success_cart_url(@current_cart.cart_id),
    })

    render json: { clientSecret: session.client_secret }
  end

  def success
    @purchased_cart = Cart.find_by_cart_id(params[:id])
    redirect_to root_path unless @purchased_cart

    @province ||= Province.first # Set a default province if none is selected

    # Create the order and order items
    ActiveRecord::Base.transaction do
      order = @current_customer.orders.create!(stripe_payment_id: params[:payment_intent])

      @invoice_items = @current_cart.cart_items.map do |cart_item|
        order.order_items.create!(
          product: cart_item.product,
          quantity: cart_item.quantity,
          price: calculate_unit_price_with_taxes(cart_item)
        )
      end
    end

    # Clear the cart
    clear_cart_items

    session[:current_cart_id] = nil if @current_cart.cart_items.empty?
  end

  def update
    @cart_item = @current_cart.cart_items.find(params[:id])
    if @cart_item.update(quantity: params[:cart_item][:quantity])
      redirect_to cart_path(@current_cart), notice: 'Quantity updated successfully.'
    else
      redirect_to cart_path(@current_cart), alert: 'Failed to update quantity.'
    end
  end

  private

  def set_product
    @product = Product.find(params[:product_id])
  end

  def set_province
    @province = Province.find(params[:province_id]) if params[:province_id].present?
  end

  def set_current_customer
    @current_customer = Customer.find_by(email: 'daniel@test.com') # Replace this with actual current customer logic
  end

  def calculate_total_price_with_taxes(cart_items, province)
    total_price = 0
    cart_items.each do |item|
      total_price += calculate_unit_price_with_taxes(item) * item.quantity
    end
    total_price
  end

  def calculate_unit_price_with_taxes(cart_item)
    unit_price = cart_item.product.price
    if @province
      gst = unit_price * @province.gst_rate
      pst = unit_price * @province.pst_rate
      hst = unit_price * @province.hst_rate
      qst = unit_price * @province.qst_rate
      unit_price += gst + pst + hst + qst
    end
    unit_price
  end

  def clear_cart_items
    @current_cart.cart_items.destroy_all
  end
end
