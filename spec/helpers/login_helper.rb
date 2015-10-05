def login
  visit root_path

  click_link "Login"

  fill_in "Username", with: user.username
  fill_in "Password", with: user.password
  click_on "Login"
end