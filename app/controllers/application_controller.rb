class ApplicationController < ActionController::Base
  respond_to :html, :json
  before_action :configure_permitted_parameters, if: :devise_controller?

  protect_from_forgery with: :exception

  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  protected

  def configure_permitted_parameters
    added_attrs = [:username, :first_name, :last_name, :address, :city, :country, :date_of_birth, :skype_handle, :phone_number, :email, :password, :password_confirmation, :remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end

  private

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(request.referrer || lists_path)
  end
end
