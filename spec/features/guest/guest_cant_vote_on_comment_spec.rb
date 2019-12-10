require 'support/features/guest_redirected_to_login.rb'
require "rails_helper"

feature "Guest tries to vote on comment" do
  scenario "unsuccessfully" do
    submission = create(:submission, :with_body, :with_comments)
    comment = submission.comments.sample

    guest_is_redirected_to_login_when_clicking_on_css_element(
      "#comments #comment-#{comment.id}>div>a:first-child",
      submission_path(submission)
    )
  end
end