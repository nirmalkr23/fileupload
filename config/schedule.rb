# config/schedule.rb
set :path, '/home/nirmalramani/RAILS/fileupload'
set :environment, :development

set :output, './log/cron.log'

every 1.minutes do
  rake "story_cleanup:delete_old"
end
  