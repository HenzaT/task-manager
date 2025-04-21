require "open-uri"

class TaskPhotoJob < ApplicationJob
  queue_as :default

  def perform(task_id)
    task = Task.find(task_id)

    client = OpenAI::Client.new
    response = client.images.generate(parameters:{
        prompt: "An image of #{task.title} or #{task.description}",
        size: "256x256"
    })

    url = response["data"][0]["url"]
    file = URI.parse(url).open

    task.photo.purge if task.photo.attached?
    task.photo.attach(io: file, filename: "ai_generated_image.jpg", content_type: "image/png")
  end
end
