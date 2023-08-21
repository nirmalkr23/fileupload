# config/schedule.rb

set :output, './log/cron.log'

every 1.minutes do
  rake "story_cleanup:delete_old"
end
  