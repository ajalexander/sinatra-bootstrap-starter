unless ENV['RACK_ENV'] == 'production'
  require 'rspec/core/rake_task'
  
  namespace :test do
    desc "Run RSpec tests"
    RSpec::Core::RakeTask.new(:specs) do |r|
      r.pattern = "test/**/*_spec.rb"
      r.rspec_opts = []
      r.rspec_opts << '--color'
      r.rspec_opts << '--format documentation'
      r.rspec_opts << '--require ./test/spec/spec_helper'
      r.rspec_opts << '--format progress'
      r.rspec_opts << "--format json --out #{File.dirname(__FILE__)}/../results/rspec.json"
    end

    require 'dotenv/tasks'

    desc "Run Cucumber tests"
    task :cukes => :dotenv do
      ruby "-S cucumber #{File.dirname(__FILE__)}/../test/feature --format pretty --format json --out results/cucumber.json"
    end

    desc "Run RSpec and Cucumber tests"
    task :all => [:specs, :cukes] do
    end
  end
end
