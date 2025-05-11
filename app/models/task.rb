require "open-uri"

class Task < ApplicationRecord
  after_save if: -> { saved_change_to_title? } do
    set_photo
  end

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "description", "due", "id", "id_value", "status", "title", "updated_at"]
  end
  has_one_attached :photo
  validates :title, :status, :due, presence: true
  validates :status, inclusion: { in: ["Completed", "In Progress"] }

  after_create_commit -> { broadcast_append_to "tasks", target: "tasks-list" }

  # after_create_commit -> { broadcast_prepend_to "tasks", partial: "tasks/task", locals: { quote: self }, target: "tasks" }

  private

  def set_photo
    TaskPhotoJob.perform_later(self.id)
  end
end
