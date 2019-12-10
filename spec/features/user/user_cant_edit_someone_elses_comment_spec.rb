require "rails_helper"

feature "user tries to edit someone elses comment" do
  scenario "but there is no edit button on the comment" do
    submission = create(:submission, :with_body, :with_comments)
    comment = submission.comments.sample

    login_as create(:user)

    visit submission_path(submission)

    expect(page).not_to have_css "a[@href='#{edit_submission_comment_path(submission, comment)}']"
  end
end