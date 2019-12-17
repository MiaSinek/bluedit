require "rails_helper"

feature "User votes on comment" do
  before(:each) do
    @submission = create(:submission, :with_body, :with_comments)
    @comment = @submission.comments.sample
    user = create(:user)

    login_as user

    visit submission_path(@submission)

    @upvote_link = find(:css, "a[href='#{upvote_path(:comment, @comment)}'][data-method='post']")
    @downvote_link = find(:css, "a[href='#{downvote_path(:comment, @comment)}'][data-method='delete']")
  end

  scenario "with upvote successfully", js: true do
    @upvote_link.click

    expect(page).to have_css("div#comment-#{@comment.id} span", text: 1)
    expect(page).to have_selector("#comment-#{@comment.id}-voting-notice", text: "Successfully upvoted comment")
  end

  scenario "with upvote twice unsuccessfully", js: true do
    2.times { @upvote_link.click }

    expect(page).to have_css("div#comment-#{@comment.id} span", text: 1)
    expect(page).to have_selector("#comment-#{@comment.id}-voting-notice", text: "You already voted for this comment")
  end

  scenario "with downvote successfully", js: true do
    @downvote_link.click

    expect(page).to have_css("div#comment-#{@comment.id} span", text: -1)
    expect(page).to have_selector("#comment-#{@comment.id}-voting-notice", text: "Successfully downvoted comment")
  end

  scenario "with downvote twice unsuccessfully", js: true do
    2.times { @downvote_link.click }

    expect(page).to have_css("div#comment-#{@comment.id} span", text: -1)
    expect(page).to have_selector("#comment-#{@comment.id}-voting-notice", text: "You already voted for this comment")
  end
end
