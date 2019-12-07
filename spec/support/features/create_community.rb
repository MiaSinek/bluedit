module Features
  def create_community
    visit root_path

    click_on "New Community"

    fill_in "community[name]", with: "rubyonrails"
    fill_in "community[title]", with: "Ruby on Rails"
    fill_in "community[sidebar]", with: "Ruby on Rails Palooza"
    fill_in "community[description]", with: "Best Ruby on Rails stuff"

    click_on "Create Community"
  end
end