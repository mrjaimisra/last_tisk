class List < ActiveRecord::Base
  belongs_to :user
  has_many :tasks

  validates :title, :status, :user_id, presence: true

  enum status: %w(unarchived archived)

end
