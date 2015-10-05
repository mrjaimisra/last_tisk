require 'rails_helper'

RSpec.feature "User can see all lists", type: :feature do

  let!(:user) { User.create(username: "Jai", password: "123") }
  let!(:list) { List.create(title: "List1", user_id: user.id) }

  before do
    login
  end

  scenario "successfully" do
    visit user_list_path(user.url, list)

    click_link "Add Task"

    expect(current_path).to eq(new_user_list_task_path(user.url, list))

    fill_in "Title", with: "New Task"
    fill_in "Description", with: "Finish reassessment project"
    fill_in "Due date", with: Date.new
    click_on "Submit"

    new_task = Task.last

    expect(current_path).to eq(user_list_task_path(user.url, list, new_task))
    expect(page).to have_content(new_task.title)
  end
end
