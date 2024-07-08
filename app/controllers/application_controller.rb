class ApplicationController < ActionController::Base

  before_action :set_categories

  private
  def set_categories
    @categories = Category.all
  end

  protected
  def check_admin_priv
    if !current_admin_user
      redirect_to root_path
    end
  end

end
