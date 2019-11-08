class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_comment, only: [:edit, :update, :destroy]
  before_action :set_submission, only: [:create, :update, :edit, :destroy, :upvote, :downvote]

  def create
    @comment = @submission.comments.new(comment_params)

    @comment.user_id = current_user.id

    @comment.save
  end

  def edit
  end

  def update
    if @comment.update(comment_params)
      redirect_to submission_path(@submission), notice: "Comment was successfully updated."
    else
      redirect_to submission_path(@submission), alert: "Comment could not be updated. Please fix indicated errors."
    end
  end

  def destroy
    @comment.destroy
    redirect_to submission_path(@submission)
  end

  def upvote
    @comment = @submission.comments.find(params[:id])

    unless current_user.voted_for? @comment
      @comment.upvote_by current_user
      flash.now[:notice] = "Successfully upvoted comment"
    else
      flash.now[:notice] = "You already voted for this comment"
    end
  end

  def downvote
    @comment = @submission.comments.find(params[:id])

    unless current_user.voted_for? @comment
      flash.now[:notice] = "Successfully downvoted comment"
      @comment.downvote_by current_user
    else
        flash.now[:notice] = "You already voted for this comment"
    end
  end

  private

  def set_submission
    @submission = Submission.find(params[:submission_id])
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end

end