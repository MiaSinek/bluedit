class Admin::SubmissionsController < ApplicationController
  def index
    @submissions = Submission.all.order(created_at: :desc)
  end
end