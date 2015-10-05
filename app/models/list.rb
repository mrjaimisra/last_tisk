class List < ActiveRecord::Base
  belongs_to :user

  validates :title, :status, :user_id, presence: true

  enum status: %w(unarchived archived)

end
