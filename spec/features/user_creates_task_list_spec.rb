require 'rails_helper'

RSpec.feature "User creates a task list", type: :feature do

  let!(:user) { User.create(username: "Jai", password: "123") }
  let!(:list) { List.create(title: "List1", user_id: user.id) }

  scenario "successfully" do
    visit lists_path

    click_on "Add A New List"

    expect(current_path).to eq(new_list_path)

    fill_in "Title", with: "New List"
    click_on "Submit"

    new_list = List.last

    expect(current_path).to eq(list_path(new_list))
    expect(page).to have_content("New List")
  end

end
