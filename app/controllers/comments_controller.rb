class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_comment, only: [:edit, :update, :destroy]
  before_action :set_submission

  def new
    #@comment = @submission.comments.new
  end

  def create
    @comment = @submission.comments.new(comment_params)

    @comment.user_id = current_user.id

    #Refactor this according to Ivan
    respond_to do |format|
      if @comment.save
        format.html { redirect_to submission_path(@submission), notice: "Comment was successfully created."  }
        #format.js #renders create.js.erb (ajax)
      else
        format.html { redirect_to submission_path(@submission), notice: "Your comment did not save. Please try again." }
        #format.js
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to submission_path(@submission), notice: "Comment was successfully updated." }
      else
        format.html { render :edit, notice: "Comment could not be updated. Please fix indicated errors." }
        #format.json { render json: @comment.errors, status: unprocessable_entity }
      end
    end
  end

  def destroy
    @comment.destroy
    redirect_to submission_path(@submission)
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