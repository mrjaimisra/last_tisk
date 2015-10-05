class Task < ActiveRecord::Base
  belongs_to :list
  belongs_to :user

  validates :title,
            :status,
            :description,
            :due_date,
            :list_id,
            presence: true

  enum status: %w(incomplete complete)
end