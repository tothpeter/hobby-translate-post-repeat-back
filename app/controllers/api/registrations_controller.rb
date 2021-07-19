# frozen_string_literal: true

class Api::RegistrationsController < DeviseTokenAuth::RegistrationsController
  before_action :configure_permitted_parameters

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :nickname])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :nickname])
  end
end
