require 'rails_helper'

RSpec.feature "User can see all tasks", type: :feature do
  let!(:user) { User.create(username: "Jai", password: "123") }
  let!(:first_list){ List.create(title: "List1", user_id: user.id) }
  let!(:second_list){ List.create(title: "List2", user_id: user.id) }

  scenario "successfully" do
    visit root_path
    click_link "All Task Lists"

    expect(current_path).to eq(lists_path)
    expect(page).to have_content(first_list.title)
    expect(page).to have_content(second_list.title)
  end
end
