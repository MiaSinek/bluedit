require "rails_helper"

feature "User votes on comment" do
  before(:each) do
    @submission = create(:submission, :with_body, :with_comments)
    @comment = @submission.comments.sample
    user = create(:user)

    login_as user

    visit submission_path(@submission)
  end

  scenario "with upvote successfully", js: true do
    find(:css, "a[href='#{upvote_submission_comment_path(@submission, @comment)}']").click

    expect(page).to have_css("div#comment-#{@comment.id} span", text: 1)
    expect(page).to have_selector("#comment-#{@comment.id}-voting-notice", text: "Successfully upvoted comment")
  end

  scenario "with downvote successfully", js: true do
    find(:css, "a[href='#{downvote_submission_comment_path(@submission, @comment)}']").click

    expect(page).to have_css("div#comment-#{@comment.id} span", text: -1)
    expect(page).to have_selector("#comment-#{@comment.id}-voting-notice", text: "Successfully downvoted comment")
  end
end
