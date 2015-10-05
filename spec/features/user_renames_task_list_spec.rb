require 'rails_helper'

RSpec.feature "User renames a task list", type: :feature do
  let!(:user) { User.create(username: "Jai", password: "123") }
  let!(:list) { List.create(title: "Things To Do", user_id: user.id)}

  before do
    login
  end

  scenario "to archived" do
    visit user_list_path(user, list)
    click_on "Edit"

    expect(current_path).to eq(edit_user_list_path(user.url, list))

    fill_in "Title", with: "Things to don't"
    click_on "Submit"

    expect(current_path).to eq(user_list_path(user.url, list))
    expect(page).to have_content("Things to don't")
  end
end
