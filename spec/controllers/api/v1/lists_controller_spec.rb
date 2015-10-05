require 'rails_helper'

RSpec.describe Api::V1::ListsController, type: :controller do

  it "returns all of a user's lists" do
    user = User.create(username: "Jai", password: "ABCD")

    get 'index', format: :json, access_token: user.token

    expect(response.status).to eq(200)
  end

  it "returns a single list" do
    user = User.create(username: "Jai", password: "ABCD")
    list = List.create(title: "List1", user_id: user.id)

    get 'index', format: :json, access_token: user.token, id: list

    expect(response.status).to eq(200)
  end
end
