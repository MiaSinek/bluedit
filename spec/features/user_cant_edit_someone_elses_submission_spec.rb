require "rails_helper"

feature "user tries to edit someone elses submission" do
  before(:each) do
    @community = create(:community, :with_submissions, submissions_count: 1)
    @user = create(:user)
    @submission = @community.submissions.last

    login_as @user
  end

  scenario "but there is no edit button on the submission's show page" do
    visit submission_path(@submission)

    expect(page).not_to have_css "a[@href='#{edit_submission_path(@submission)}']"
  end

  scenario "but there is no edit button on the root path" do
    create(:subscription, user: @user, community: @community)

    visit root_path(@submission)

    expect(page).to have_css "div[id='submission-#{@submission.id}']"
    expect(page).not_to have_css "a[href='#{edit_submission_path(@submission)}']"
  end

  scenario "but there is no edit button on community listing page" do
    visit community_path(@community)

    expect(page).to have_css "div[id='submission-#{@submission.id}']"
    expect(page).not_to have_css "a[href='#{edit_submission_path(@submission)}']"
  end

  scenario "when trying to load the edit page of a submission created by someone else, user is redirected to the submission's show page with flash message" do
    visit edit_submission_path(@submission)

    expect(current_path).to eq(submission_path(@submission))
    expect(page).to have_text("You can not edit someone else's submission. Sorryyy!")
  end
end