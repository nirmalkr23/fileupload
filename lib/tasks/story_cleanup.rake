# lib/tasks/story_cleanup.rake
namespace :story_cleanup do
  desc "Delete stories older than 5 minutes"
  task delete_old: :environment do
    Story.delete_old_stories
  end
end
