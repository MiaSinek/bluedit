require "rails_helper"

feature "user creates community" do
  scenario "successfully" do
    user = create(:user)

    sign_in user.email, user.password

    click_on "New Community"

    fill_in "community[name]", with: "rubyonrails"
    fill_in "community[title]", with: "Ruby on Rails"
    fill_in "community[sidebar]", with: "Ruby on Rails Palooza"
    fill_in "community[description]", with: "Best Ruby on Rails stuff"

    click_on "Create Community"

    expect(page).to have_css "h1", text: "w/rubyonrails"
    expect(page).to have_css "h3", text: "Ruby on Rails"
  end
end