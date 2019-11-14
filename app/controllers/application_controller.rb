class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :find_communities

  def search
    q = params[:q]
    @community_results  = Community.ransack(name_cont: q).result
    @submission_results = Submission.ransack(title_cont: q).result
    @user_results = User.ransack(username_cont: q).result
  end

  protected

  def find_communities
    @communities = Community.all
  end

  def configure_permitted_parameters
    added_attributes = [:username, :comment_subscription]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attributes
    devise_parameter_sanitizer.permit :account_update, keys: added_attributes
  end
end
