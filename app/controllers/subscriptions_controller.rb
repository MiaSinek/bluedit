class SubscriptionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_community, only: [:create, :destroy]

  def create
    @subscription = @community.subscriptions.where(user_id: current_user.id).first_or_create
  end

  def destroy
    @subscription = @community.subscriptions.find_by(user_id: current_user.id)
    @subscription.destroy
  end

  private

    def set_community
      @community = Community.find(params[:community_id])
    end
end