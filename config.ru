require './app'

set :environment, ENV['RACK_ENV'].to_sym
set :app_file, 'app.rb'
disable :run
disable :logging

if ENV['RACK_ENV'] == 'development'
  $stdout.sync = true
end

run App
