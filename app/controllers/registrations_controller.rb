class RegistrationsController < Devise::RegistrationsController

  private

  def sign_up_params
    params.require(:customer).permit(:first_name, :last_name, :email, :password, :password_confirmation, :province_id)
  end

  def account_update_params
    params.require(:customer).permit(:first_name, :last_name, :email, :password, :password_confirmation, :current_password, :province_id)
  end
end
