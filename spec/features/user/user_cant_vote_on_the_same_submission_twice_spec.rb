require "rails_helper"


feature "User votes on submission twice" do
  scenario "unsuccessfully", js: true do
    community = create(:community, :with_submissions, submissions_count: 1)
    submission = community.submissions.last
    user = create(:user)

    login_as user

    visit submission_path(submission)

    upvote_link = find(:css, "a[href='#{upvote_submission_path(submission)}']")
    downvote_link = find(:css, "a[href='#{downvote_submission_path(submission)}']")


    upvote_link.click
    downvote_link.click

    expect(page).to have_css("div#submission-#{submission.id} div.submission-voting span", text: 1)
    expect(page).to have_selector("#voting-notice", text: "You already voted for this submission")
  end
end