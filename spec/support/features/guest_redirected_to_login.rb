module Features
  def guest_is_redirected_to_login_when_clicking_on_text(link_text, path=root_path)
    visit path
    click_on link_text

    expect(page).to have_current_path(new_user_session_path)
    expect(page).to have_text "You need to log in or sign up before continuing."
  end

  def guest_is_redirected_to_login_when_clicking_on_css_element(css_query, path=root_path)
    visit path
    find(:css, css_query).click

    expect(page).to have_current_path(new_user_session_path)
    expect(page).to have_text "You need to log in or sign up before continuing."
  end
end