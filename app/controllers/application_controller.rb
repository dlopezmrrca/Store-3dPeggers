class ApplicationController < ActionController::Base
  before_action :set_current_cart
  before_action :set_categories, unless: :active_admin_page?

  private

  def set_categories
    @categories = Category.all
  end

  def active_admin_page?
    params[:controller].start_with?('admin/')
  end

  def set_current_cart
    if session[:current_cart_id]
      @current_cart =  Cart.find_by_cart_id(session[:current_cart_id])
    else
      @current_cart = Cart.create
      session[:current_cart_id] = @current_cart.cart_id
    end
  end

  protected

  def check_admin_priv
    redirect_to root_path unless current_admin_user
  end
end
