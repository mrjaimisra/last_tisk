require 'rails_helper'

RSpec.describe ApiKey, type: :model do
  it "generates a unique token before create" do
    token = ApiKey.create!

    expect(token.access_token).to_not eq(nil)
  end
end
