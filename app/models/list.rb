class List < ActiveRecord::Base

  enum status: %w(unarchived archived)

end
