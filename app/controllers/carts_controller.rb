class CartsController < ApplicationController
before_action :set_current_cart
 def create
  @current_cart.cart_items.create(product_id: params[:product_id])
 end
end
