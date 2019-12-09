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
    submission = create(:submission, :with_body)
    guest_is_redirected_to_login_when_clicking_on_css_element("#submission-1 .submission-voting a:first-child")
  end

  scenario "upvote submission on submission's show page" do
    submission = create(:submission, :with_body)

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

  scenario "edit submisssion, but there is no edit button on the submission's show page" do
    submission = create(:submission, :with_body)
    visit submission_path(submission)

    expect(page).not_to have_css "a[@href='#{edit_submission_path(submission)}']"
  end

  scenario "edit submisssion, but there is no edit button on the root path" do
    submission = create(:submission, :with_body)

    visit root_path

    expect(page).to have_css "div[id='submission-#{submission.id}']"
    expect(page).not_to have_css "a[href='#{edit_submission_path(submission)}']"
  end

  scenario "edit submisssion, but there is no edit button on community listing page" do
    submission = create(:submission, :with_body)
    visit community_path(submission.community)

    expect(page).to have_css "div[id='submission-#{submission.id}']"
    expect(page).not_to have_css "a[href='#{edit_submission_path(submission)}']"
  end

  scenario "when trying to load the edit page of a submission, guest is redirected to the submission's show page with flash message" do
    submission = create(:submission, :with_body)
    visit edit_submission_path(submission)

    expect(current_path).to eq(new_user_session_path)
    expect(page).to have_text("You need to log in or sign up before continuing.")
  end
end
