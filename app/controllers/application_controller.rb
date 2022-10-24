# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  include Pundit::Authorization
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  rescue_from ActiveRecord::RecordNotFound, with: :id_record_not_found

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name user_type])
  end

  private

  def user_not_authorized
    flash[:alert] = I18n.t('authorization.not_authorized')
    redirect_back(fallback_location: root_path)
  end

  def id_record_not_found
    flash[:error] = I18n.t('authorization.not_authorized')
    redirect_to(root_path)
  end
end
