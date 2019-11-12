class NotificationSubscriptionsController < ApplicationController
  def unsubscribe
    user = User.find_by(unsubscribe_hash: params[:unsubscribe_hash])
    user.update_attribute(:comment_subscription, false)
  end
end