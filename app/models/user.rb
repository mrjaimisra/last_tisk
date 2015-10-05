class User < ActiveRecord::Base
  has_secure_password

  has_many :lists
  has_many :tasks

  validates :username, :password, :url, presence: true
  validates :username, uniqueness: true

  before_validation :generate_url
  before_create :set_auth_token

  def generate_url
    self.url = username.parameterize
  end

  def set_auth_token
    self.token = ApiKey.create!.access_token
  end
end
