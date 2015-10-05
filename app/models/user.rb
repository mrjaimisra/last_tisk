class User < ActiveRecord::Base
  has_secure_password

  has_many :lists

  validates :username, :password, :url, presence: true
  validates :username, uniqueness: true

  before_validation :generate_url

  def generate_url
    self.url = username.parameterize
  end
end
