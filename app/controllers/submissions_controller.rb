class SubmissionsController < ApplicationController
  before_action :set_submission, only: [:show, :edit, :update, :destroy, :upvote, :downvote]
  before_action :authenticate_user!, except: [:show, :index]

  # GET /submissions
  # GET /submissions.json
  def index
    @submissions = if user_signed_in?
      current_user.submissions_subscribed_to
    else
      Submission.all
    end
  end

  # GET /submissions/1
  # GET /submissions/1.json
  def show
    @comment = Comment.new
  end

  # GET /submissions/new
  def new
    @submission = current_user.submissions.new
  end

  # GET /submissions/1/edit
  def edit
  end

  # POST /submissions
  # POST /submissions.json
  def create
    @submission = current_user.submissions.new(submission_params)

    respond_to do |format|
      if @submission.save
        format.html { redirect_to @submission, notice: 'Submission was successfully created.' }
        format.json { render :show, status: :created, location: @submission }
      else
        format.html { render :new }
        format.json { render json: @submission.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /submissions/1
  # PATCH/PUT /submissions/1.json
  def update
    respond_to do |format|
      if @submission.update(submission_params)
        format.html { redirect_to @submission, notice: 'Submission was successfully updated.' }
        format.json { render :show, status: :ok, location: @submission }
      else
        format.html { render :edit }
        format.json { render json: @submission.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /submissions/1
  # DELETE /submissions/1.json
  def destroy
    @submission.destroy
    respond_to do |format|
      format.html { redirect_to submissions_url, notice: 'Submission was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def upvote
    respond_to do |format|
      unless current_user.voted_for? @submission
        @submission.upvote_by current_user
        # format.html { redirect_back(fallback_location: root_path, notice: 'Glad you liked it!') }
        # format.json { head :no_content }
        format.js { flash.now[:notice] = "Successfully upvoted submission" }
      else
        # format.html { redirect_back(fallback_location: root_path, notice: "Nah, I didn't like it either!")  }
        # format.json { head :no_content }
        format.js { flash.now[:notice] = "You already voted for this submission" }
      end
    end
  end

  def downvote
    respond_to do |format|
      unless current_user.voted_for? @submission
        format.html { redirect_back(fallback_location: root_path) }
        format.json { head :no_content }
        format.js { flash.now[:notice] = "Successfully downvoted submission" }
        @submission.downvote_by current_user
      else
        format.html { redirect_back(fallback_location: root_path)  }
        format.json { head :no_content }
        format.js { flash.now[:notice] = "You already voted for this submission" }
      end
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
