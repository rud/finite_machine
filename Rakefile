require "bundler/gem_tasks"

begin
  require 'rspec/core/rake_task'

  desc 'Run all specs'
  RSpec::Core::RakeTask.new(:spec) do |task|
    task.pattern = 'spec/{unit,integration}{,/*/**}/*_spec.rb'
  end

  namespace :spec do
    desc 'Run unit specs'
    RSpec::Core::RakeTask.new(:unit) do |task|
      task.pattern = 'spec/unit{,/*/**}/*_spec.rb'
    end

    desc 'Run integration specs'
    RSpec::Core::RakeTask.new(:integration) do |task|
      task.pattern = 'spec/integration{,/*/**}/*_spec.rb'
    end
  end

rescue LoadError
  %w[spec spec:unit spec:integration].each do |name|
    task name do
      $stderr.puts "In order to run #{name}, do `gem install rspec`"
    end
  end
end

desc 'Run all specs'
task ci: %w[ spec ]

desc 'Measure code coverage'
task :coverage do
  begin
    original, ENV['COVERAGE'] = ENV['COVERAGE'], 'true'
    Rake::Task['spec'].invoke
  ensure
    ENV['COVERAGE'] = original
  end
end

desc 'Load gem inside irb console'
task :console do
  require 'irb'
  require 'irb/completion'
  require File.join(__FILE__, '../lib/finite_machine')
  ARGV.clear
  IRB.start
end
