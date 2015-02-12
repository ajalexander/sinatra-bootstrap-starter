ENV['RACK_ENV'] = 'test'

require 'database_cleaner'
require 'sequel'
require 'simplecov'
require 'simplecov-rcov'

SimpleCov.formatter = SimpleCov::Formatter::RcovFormatter

SimpleCov.start do
  coverage_dir "#{__dir__}/../../results/coverage"
  command_name 'RSpec'

  add_filter "test"
  add_filter "db/migrations"
end

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.before(:suite) do
    DB ||= Sequel.connect('sqlite:/')

    Sequel.extension :migration
    Sequel::Migrator.apply(DB, "#{__dir__}/../../db/migrations")

    DatabaseCleaner.strategy = :truncation

    require_relative '../../models/init'
    require_relative '../seed'
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end
