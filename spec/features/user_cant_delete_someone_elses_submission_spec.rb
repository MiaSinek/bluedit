require "rails_helper"

feature "user tries to delte someone elses submission" do
  before(:each) do
    @submission = create(:submission, :with_body)
    @user = create(:user)

    login_as @user
  end

  scenario "but there is no delete button on the submission's show page" do
    visit submission_path(@submission)

    expect(page).not_to have_css "a[href='#{submission_path(@submission)}'][role='delete-submission']"
  end

  scenario "but there is no delete button on the root path" do
    create(:subscription, user: @user, community: @submission.community)

    visit root_path

    expect(page).to have_css "div[id='submission-#{@submission.id}']"
    expect(page).not_to have_css "a[href='#{submission_path(@submission)}'][role='delete-submission']"
  end

  scenario "but there is no delete button on community listing page" do
    visit community_path(@submission.community)

    expect(page).to have_css "div[id='submission-#{@submission.id}']"
    expect(page).not_to have_css "a[href='#{submission_path(@submission)}'][role='delete-submission']"
  end
end