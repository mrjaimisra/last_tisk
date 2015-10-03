require 'rails_helper'

RSpec.feature "User can see all tasks", type: :feature do
  scenario "successfully" do
    visit root_path
    click_link "All Task Lists"

    expect(current_path).to eq(lists_path)
   end
end
