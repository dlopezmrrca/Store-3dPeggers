class CartsController < ApplicationController
  before_action :set_product, only: [:create, :destroy]

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
  end

  def checkout
  end

  def destroy
    @cart_item = @current_cart.cart_items.find_by(product_id: @product.id)
    @cart_item.destroy
    redirect_to cart_path(@current_cart)
  end

  def stripe_session
    session = Stripe::Checkout::Session.create({
      ui_mode: 'embedded',
      line_items: @current_cart.cart_items.map do |item|
        {
          price_data: {
            currency: "usd",
            unit_amount: (item.product.price * 100).to_i,
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
    if @current_cart.cart_items.any?
      session[:current_cart_id] = nil
    end
    @purchased_cart = Cart.find_by_cart_id(params[:id])
    redirect_to root_path if !@purchased_cart
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
end
