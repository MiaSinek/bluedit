module Features; end
require "rails_helper"


feature "User upvotes submission" do
  scenario "successfully", js: true do
    community = create(:community, :with_submissions, submissions_count: 1)
    submission = community.submissions.last
    user = create(:user)

    login_as(user, :scope => :user)

    visit submission_path(submission)

    find(:css, "a[href='#{upvote_submission_path(submission)}']").click

    expect(page).to have_css("div#submission-#{submission.id} div.submission-voting span", text: 1)
  end
end

feature "User downvotes submission" do
  scenario "successfully", js: true do
    community = create(:community, :with_submissions, submissions_count: 1)
    submission = community.submissions.last
    user = create(:user)

    login_as(user, :scope => :user)

    visit submission_path(submission)

    find(:css, "a[href='#{downvote_submission_path(submission)}']").click

    expect(page).to have_css("div#submission-#{submission.id} div.submission-voting span", text: -1)
  end
end
