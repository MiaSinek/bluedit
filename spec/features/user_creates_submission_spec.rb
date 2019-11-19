require "rails_helper"

feature "user creates submission", js: true do
  scenario "of type 'post' successfully" do
    user = User.create(username: "Someone", email: "someone@example.com", password: "password", password_confirmation: "password")

    community = Community.create(name: 'testcomm1', title: 'Test Community 1', user_id: user.id)

    sign_in user.email, user.password

    click_on "New Submission"

    fill_in 'submission[title]', with: 'Test Submission'

    # Only works with JS turned on!
    find('trix-editor').click.set('Test Submission Body!')

    select community.name, from: 'submission[community_id]'

    click_on "Create Submission"

    expect(page).to have_css('h1', text:"w/#{community.name}")
    expect(page).to have_css('h1', text: 'Test Submission')
    expect(page).to have_css('div.trix-content', text: 'Test Submission Body!')
  end
end