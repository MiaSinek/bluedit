require "rails_helper"

feature "User upvotes submission" do
  scenario "successfully", js: true do
    community = create(:community, :with_submissions, submissions_count: 1)
    submission = community.submissions.last
    user = create(:user)

    login_as user

    visit submission_path(submission)

    find(:css, "a[href='#{upvote_path(type: :submission, id: submission.id)}'][data-method='post']").click

    expect(page).to have_css("div#submission-#{submission.id} div.submission-voting span", text: 1)
  end
end

feature "User downvotes submission" do
  scenario "successfully", js: true do
    community = create(:community, :with_submissions, submissions_count: 1)
    submission = community.submissions.last
    user = create(:user)

    login_as user

    visit submission_path(submission)

    find(:css, "a[href='#{downvote_path(type: :submission, id: submission.id)}'][data-method='delete']").click

    expect(page).to have_css("div#submission-#{submission.id} div.submission-voting span", text: -1)
  end
end
