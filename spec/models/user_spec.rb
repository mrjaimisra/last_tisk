require 'rails_helper'

RSpec.describe "a user", type: :model do
  context "that has just been created" do
    let!(:user) { User.create(username: "Jai", password: "1234") }

    it "has a url attributed" do
      expect(user.url).to eq("jai")
    end

    it "has an auth token" do
      expect(user.token).to_not eq(nil)
    end
  end
end

# def generate_url
#   self.url = username.parameterize
# end
#
# def set_auth_token
#   return if token.present?
#   self.token = generate_auth_token
# end

