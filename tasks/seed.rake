unless ENV['RACK_ENV'] == 'production'
  namespace :db do
    desc "Load seed data"
    task :seed do
      require_relative '../models/init'
      require_relative '../test/seed'
    end
  end
end