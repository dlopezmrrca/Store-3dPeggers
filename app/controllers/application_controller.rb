class ApplicationController < ActionController::Base
  before_action :set_categories, unless: :active_admin_page?

  private

  def set_categories
    @categories = Category.all
  end

  def active_admin_page?
    params[:controller].start_with?('admin/')
  end

  protected

  def check_admin_priv
    redirect_to root_path unless current_admin_user
  end
end
