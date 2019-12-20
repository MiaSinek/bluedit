class SubmissionPolicy
  class Scope
    def initialize(current_user, action)
      @current_user = current_user
      @action = action
    end

    def scope
      if signed_in_user_visiting_homepage?
        @current_user.submissions_subscribed_to
      elsif signed_in_user_creating_submission?
        @current_user.submissions
      else
        Submission.all
      end
    end

    private

    def signed_in_user_visiting_homepage?
      @current_user.present? && @action == 'index'
    end

    def signed_in_user_creating_submission?
      @current_user.present? && @action == 'create'
    end
  end
end