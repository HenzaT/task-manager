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
  validates :status, inclusion: { in: ["Completed", "In Progress", "Not Started"] }

  private

  def set_photo
    client = OpenAI::Client.new
    response = client.images.generate(parameters: {
      prompt: "An image of #{title} or #{description}", size: "256x256"
    })

    url = response["data"][0]["url"]
    file = URI.parse(url).open

    photo.purge if photo.attached?
    photo.attach(io: file, filename: "ai_generated_image.jpg", content_type: "image/png")
    return photo
  end
end
