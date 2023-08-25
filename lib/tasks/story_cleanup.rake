# lib/tasks/story_cleanup.rake
namespace :story_cleanup do
  desc "Delete stories older than 5 minutes"
  task delete_old: :environment do
    Story.delete_old_stories
    File.open(Rails.root.join('log', 'cron.log'), 'a') do |f|
      f.puts "Story cleanup rake task completed successfully at #{Time.now}"
    end
  end
end
