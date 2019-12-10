require "rails_helper"

feature "guest tries to delete comment on the submisson's show page" do
  scenario "but there is no delete button" do
    submission = create(:submission, :with_body, :with_comments)
    comment = submission.comments.sample

    visit submission_path(submission)

    expect(page).not_to have_css "a[href='#{submission_comment_path(submission, comment)}'][data-method='delete']"
  end
end