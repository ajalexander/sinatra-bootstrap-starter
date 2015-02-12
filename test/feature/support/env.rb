ENV['RACK_ENV'] = 'test'

require 'capybara/cucumber'
require 'capybara/webkit'
require 'database_cleaner'
require 'rspec'
require 'sequel'
require 'simplecov'
require 'simplecov-rcov'

# Configure Coverage
SimpleCov.formatter = SimpleCov::Formatter::RcovFormatter

SimpleCov.start do
  coverage_dir "#{__dir__}/../../../results/coverage"
  command_name 'Cucumber'

  add_filter "test"
  add_filter "db/migrations"
end

# Setup the database

DB ||= Sequel.connect('sqlite:/')

Sequel.extension :migration
Sequel::Migrator.apply(DB, "#{__dir__}/../../../db/migrations")

DatabaseCleaner.strategy = :truncation

require_relative '../../../models/init'
require_relative '../../seed'

# Configure mocking and data cleanup

World(RSpec::Mocks::ExampleMethods)

Before do
  RSpec::Mocks.setup

  DatabaseCleaner.strategy = :transaction
  DatabaseCleaner.start
end

After do
  begin
    RSpec::Mocks.verify
  ensure
    DatabaseCleaner.clean
    RSpec::Mocks.teardown
  end
end

# Setup the application

require_relative '../../../app'

Capybara.app = App
Capybara.default_wait_time = 10
Capybara.javascript_driver = :webkit

World do
  App.new
end
