require "rails_helper"


feature "User votes on submission twice" do
  scenario "unsuccessfully", js: true do
    community = create(:community, :with_submissions, submissions_count: 1)
    submission = community.submissions.last
    user = create(:user)

    login_as user

    visit submission_path(submission)

    upvote_link = find(:css, "a[href='#{upvote_path(type: :submission, id: submission.id)}'][data-method='post']")
    downvote_link = find(:css, "a[href='#{downvote_path(type: :submission, id: submission.id)}'][data-method='delete']")


    upvote_link.click
    downvote_link.click
    upvote_link.click

    expect(page).to have_css("div#submission-#{submission.id} div.submission-voting span", text: 1)
    expect(page).to have_selector("div#submission-#{submission.id}-voting-notice", text: "You already voted for this submission")
  end
end