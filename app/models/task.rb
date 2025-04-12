class Task < ApplicationRecord
  validates :title, :status, :due, presence: true
  validates :status, inclusion: { in: ["Completed", "In Progress", "Not Started"] }
end
