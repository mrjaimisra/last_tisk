require 'rails_helper'

RSpec.describe Users::ListsController, type: :controller do
  describe "GET index" do

    before { allow(controller).to receive(:current_user) { user } }
    let!(:user) { User.create(username: "Jai", password: "123") }
    let!(:list) { List.create(title: "Jai", user_id: user.id) }

    it "assigns @lists" do
      get :index, user: user
      expect(assigns(:lists)).to eq([list])
    end

    it "renders the index template" do
      get :index, user: user
      expect(response).to render_template("index")
    end

    it "assigns @list" do
      get :new, user: user
      expect(assigns(:list)).to be_a_new(List)
    end

    it "renders the new template" do
      get :new, user: user
      expect(response).to render_template("new")
    end

    it "assigns @list" do
      get :edit, user: user, id: list.id
      expect(assigns(:list)).to eq(list)
    end

    it "renders the edit template" do

      get :edit, user: user, id: list.id
      expect(response).to render_template("edit")
    end
  end
end
