class Task < ApplicationRecord
  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "description", "due", "id", "id_value", "status", "title", "updated_at"]
  end
  validates :title, :status, :due, presence: true
  validates :status, inclusion: { in: ["Completed", "In Progress", "Not Started"] }
end
