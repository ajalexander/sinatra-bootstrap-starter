require 'rubygems'
require 'bundler'
require 'dotenv'

Dir.glob('tasks/*.rake').each { |r| import r }

begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end

Dotenv.load

task :default => [:start]

desc "Start application based on environment"
task :start do
  exec("rackup config.ru")
end

task :environment, [:env] do |cmd, args|
  ENV["RACK_ENV"] = args[:env] || "development"
end
