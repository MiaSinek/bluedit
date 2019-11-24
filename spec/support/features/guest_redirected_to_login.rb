module Features
  def guest_is_redirected_to_login_when_clicking_on(link_text)
    visit root_path
    click_on link_text

    expect(page).to have_current_path(new_user_session_path)
    expect(page).to have_text "You need to log in or sign up before continuing."
  end
end