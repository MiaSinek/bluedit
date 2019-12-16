class VotesController < ApplicationController
  before_action :authenticate_user!

  def create
    flash.now[:notice] = attempt_to :upvote, params[:type]

    render partial: 'vote'
  end


  def destroy
    flash.now[:notice] = attempt_to :downvote, params[:type]

    render partial: 'vote'
  end

  private

  def attempt_to(action, type)
    find_vote_subject

    if subject_not_voted_on_yet?
      vote!(action)
      "Successfully #{action}d #{type}"
    else
      "You already voted for this #{type}"
    end
  end

  def find_vote_subject
    @vote_subject = model_class.find(params[:id])
  end

  def model_class
    params[:type].capitalize.constantize
  end

  def subject_not_voted_on_yet?
    !current_user.voted_for?(@vote_subject)
  end

  def vote!(action)
    @vote_subject.send("#{action}_by", current_user)
  end
end

