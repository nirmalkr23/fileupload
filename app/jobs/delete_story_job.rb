class DeleteStoryJob < ApplicationJob
  queue_as :default

  def perform(story_id)
    story = Story.find_by(id: story_id)
    story&.destroy
  end
end