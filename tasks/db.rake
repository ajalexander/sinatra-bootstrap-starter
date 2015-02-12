namespace :db do
  require 'sequel'
  Sequel.extension :migration

  require_relative '../models/init'

  # Uncomment the following to see SQL output
  #require 'logger'
  #DB.loggers << Logger.new($stdout)

  desc "Prints the schema version"
  task :version do
    version = if DB.tables.include?(:schema_info)
      DB[:schema_info].first[:version]
    end || 0

    puts "Schema Version: #{version}" 
  end

  desc "Perform migration up to latest migration available"
  task :migrate do
    Sequel::Migrator.run(DB, "db/migrations")
    Rake::Task['db:version'].execute
  end

  desc "Perform rollback to specified target or full rollback as default"
  task :rollback, :target do |t, args|
    args.with_defaults(:target => 0)

    Sequel::Migrator.run(DB, "db/migrations", :target => args[:target].to_i)
    Rake::Task['db:version'].execute
  end

  unless ENV['RACK_ENV'] == 'production'
    desc "Perform migration reset (full rollback and migration)"
    task :reset do
      Sequel::Migrator.run(DB, "db/migrations", :target => 0)
      Sequel::Migrator.run(DB, "db/migrations")
      Rake::Task['db:version'].execute
    end
  end
end
