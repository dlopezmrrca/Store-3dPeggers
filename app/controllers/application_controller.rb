class ApplicationController < ActionController::Base

  protected

  def check_admin_priv
    if !current_admin_user
      redirect_to root_path
    end
  end

end
