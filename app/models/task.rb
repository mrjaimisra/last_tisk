class Task < ActiveRecord::Base
  belongs_to :list

  validates :title,
            :status,
            :description,
            :due_date,
            :list_id,
            presence: true

  enum status: %w(incomplete complete)
end