require 'support/features/guest_redirected_to_login.rb'
require "rails_helper"

feature "guest tries to perform unauthorized action:" do
  scenario "create community" do
    guest_is_redirected_to_login_when_clicking_on_text "New Community"
  end

  scenario "create submission" do
    guest_is_redirected_to_login_when_clicking_on_text "New Submission"
  end

  scenario "upvote submission on homepage" do
    community = create(:community, :with_submissions)
    guest_is_redirected_to_login_when_clicking_on_css_element("#submission-1 .submission-voting a:first-child")
  end

  scenario "upvote submission on submission's show page" do
    community = create(:community, :with_submissions)
    submission = community.submissions.last

    guest_is_redirected_to_login_when_clicking_on_css_element(
      "#submission-#{submission.id} .submission-voting a:first-child",
      submission_path(submission)
    )
  end

  scenario "upvote submission on any user's show page" do
    community = create(:community, :with_submissions)
    submission = community.submissions.sample
    user = submission.user

    guest_is_redirected_to_login_when_clicking_on_css_element(
      "#submission-#{submission.id} .submission-voting a:first-child",
      profile_path(user)
    )
  end

  scenario "upvote comment on submission's show page" do
    community = create(:community)
    submission = create(:submission, :with_body, :with_comments, community: community)
    comment = submission.comments.sample

    guest_is_redirected_to_login_when_clicking_on_css_element(
      "#comments #comment-#{comment.id}>div>a:first-child",
      submission_path(submission)
    )
  end
end
