require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe "GET index" do
    let!(:user) { User.create(username: "Jai", password: "123") }

    it "assigns @user" do

      post :create, session: { username: user.username, password: user.password }

      expect(response).to redirect_to(user_lists_path(user.url))
    end

    it "renders the new template" do
      get :new
      expect(response).to render_template("new")
    end
  end
end
