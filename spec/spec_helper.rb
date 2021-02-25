
ENV['RACK_ENV'] = 'test'
require "./config/environment"
require 'simplecov'
SimpleCov.start

require 'capybara/dsl'
Capybara.app = SetList
Capybara.save_path = 'tmp/capybara'

# within the RSpec configuration (this is the same place you have your database cleaner options set):

  c.include Capybara::DSL
# See http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration
RSpec.configure do |config|
  config.before(:each) do
    $db = []
  end 

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.filter_run :focus
  config.run_all_when_everything_filtered = true
  config.disable_monkey_patching!
  config.warnings = true
  if config.files_to_run.one?
    config.default_formatter = 'doc'
  end 
  config.profile_examples = 10
  config.order = :random
  Kernel.srand config.seed
end
