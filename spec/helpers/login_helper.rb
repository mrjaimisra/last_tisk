def login
  visit root_path

  within(".header-nav") do
    click_link "Login"
  end

  within(".login-form") do
    fill_in "Username", with: user.username
    fill_in "Password", with: user.password
    click_button "Login"
  end
end