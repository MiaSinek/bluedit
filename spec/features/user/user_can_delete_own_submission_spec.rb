require "rails_helper"

feature "user deletes own submission" do
  scenario "successfully" do
    submission = create(:submission, :with_body)

    login_as submission.user

    visit submission_path(submission)

    find(:css, "a[role='delete-submission']").click

    expect(page).to have_text "Submission was successfully destroyed."
    expect(page).not_to have_css "div#submission-#{submission.id}"
    expect(page).to have_current_path(submissions_path)
  end
end

feature "There is a 'Delete' link" do
  before(:each) do
    @submission = create(:submission, :with_body)
    login_as @submission.user
  end

  scenario "on the root path to the user's own submission" do
    create(:subscription, community: @submission.community, user: @submission.user)

    visit root_path

    expect(page).to have_xpath "//a[contains(@href,'#{@submission.id}') and @role='delete-submission']"
  end

  scenario "on the community's index page to the user's own submission" do
    visit community_path(@submission.community)

    expect(page).to have_xpath "//a[contains(@href,'#{@submission.id}') and @role='delete-submission']"
  end
end