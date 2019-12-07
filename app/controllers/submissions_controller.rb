class SubmissionsController < ApplicationController
  before_action :set_submission, only: [:show, :edit, :update, :destroy, :upvote, :downvote]
  before_action :authenticate_user!, except: [:show, :index]

  def index
    @submissions = if user_signed_in?
      current_user.submissions_subscribed_to
    else
      Submission.all
    end
  end

  def show
    @comment = Comment.new
  end

  def new
    @submission = current_user.submissions.new
  end

  def edit
    if current_user != @submission.user
      redirect_to @submission, alert: "You can not edit someone else's submission. Sorryyy!"
    end
  end

  def create
    @submission = current_user.submissions.new(submission_params)

    if @submission.save
      redirect_to @submission, notice: 'Submission was successfully created.'
    else
      render :new
    end
  end

  def update
    if @submission.update(submission_params)
      redirect_to @submission, notice: 'Submission was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @submission.destroy

    redirect_to submissions_url, notice: 'Submission was successfully destroyed.'
  end

  def upvote
    unless current_user.voted_for? @submission
      @submission.upvote_by current_user
      flash.now[:notice] = "Successfully upvoted submission"
    else
      flash.now[:notice] = "You already voted for this submission"
    end
  end

  def downvote
    unless current_user.voted_for? @submission
      flash.now[:notice] = "Successfully downvoted submission"
      @submission.downvote_by current_user
    else
      flash.now[:notice] = "You already voted for this submission"
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_submission
      @submission = Submission.find(params[:id])
    end

    # Never trust parameters from the internet, only allow the white list through.
    def submission_params
      params.require(:submission).permit(:title, :body, :url, :submission_image, :submission_video, :community_id)
    end
end
