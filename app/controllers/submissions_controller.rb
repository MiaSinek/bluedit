class SubmissionsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]

  def index
    load_submissions
  end

  def show
    load_submission
    build_comment
  end

  def new
    build_submission
  end

  def create
    build_submission
    save_submission('Submission was successfully created.') or render :new
  end

  def edit
    load_submission
    redirect_if_not_author or build_submission
  end


  def update
    load_submission
    build_submission
    save_submission('Submission was successfully updated.') or render :edit
  end

  def destroy
    load_submission
    @submission.destroy

    redirect_to submissions_path, notice: 'Submission was successfully destroyed.'
  end

  private

  def load_submissions
    @submissions ||= submission_scope.to_a
  end

  def load_submission
    @submission ||=  submission_scope.find(params[:id])
  end

  def redirect_if_not_author
    if current_user != @submission.user
      redirect_to @submission, alert: "You can not edit someone else's submission. Sorryyy!"
    end
  end

  def build_submission
    @submission ||= submission_scope.build
    @submission.attributes = submission_params
  end

  def build_comment
    @comment = Comment.new
  end

  def save_submission(notice)
    if @submission.save
      redirect_to @submission, notice: notice
    end
  end

  def submission_scope
    if signed_in_user_visiting_homepage?
      current_user.submissions_subscribed_to
    elsif signed_in_user_creating_submission?
      current_user.submissions
    else
      Submission.all
    end
  end

  def signed_in_user_visiting_homepage?
    user_signed_in? && params[:action] == 'index'
  end

  def signed_in_user_creating_submission?
    user_signed_in? && params[:action] == 'create'
  end

  def submission_params
    submission_params = params[:submission]
    submission_params ? submission_params.permit(:title, :body, :url, :submission_image, :submission_video, :community_id) : {}
  end
end