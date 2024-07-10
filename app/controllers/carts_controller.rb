class CartsController < ApplicationController
before_action :set_current_cart
 def create
  @current_cart.cart_items.create(product_id: params[:product_id])
 end
 def show

 end

 def checkout

 end

 def stripe_session
  session = Stripe::Checkout::Session.create({
    ui_mode: 'embedded',
    line_items: [{
        # Provide the exact Price ID (e.g. pr_1234) of the product you want to sell
        price_data: {
          currency: "usd",
          # convert decimal price to cents
          unit_amount: (@current_cart.products.sum(&:price) * 100).to_i,
          product_data: {
            name: @current_cart.products.map(&:name).join(", ")
          },
        },
        quantity: 1,
      }],
      # shipping_address_collection: {
      #   allowed_countries: STRIPE_SUPPORTED_COUNTRIES
      # },
      mode: 'payment',
      return_url: success_cart_url(@current_cart.cart_id),
    })

  render json: { clientSecret: session.client_secret }
end

 def success
 end
end
