class VotesController < ApplicationController
  before_action :authenticate_user!

  def create
    vote(:upvote)
  end


  def destroy
    vote(:downvote)
  end

  private

  def vote(action)
    vote_subject = VoteSubjectFinder.find(params[:type], params[:id])

    notice = VoteCreator.new(current_user,
                             action,
                             vote_subject).attempt_to_vote

    flash.now[:notice] = notice

    render partial: 'vote', :locals => { vote_subject: vote_subject }
  end
end

