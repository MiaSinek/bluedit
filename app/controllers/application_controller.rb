class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :find_communities

  protected

  def find_communities
    @communities = Community.all
  end

  def configure_permitted_parameters
    added_attributes = [:username]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attributes
    devise_parameter_sanitizer.permit :account_update, keys: added_attributes
  end
end
