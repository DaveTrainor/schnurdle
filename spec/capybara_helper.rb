require_relative '../wordle_first_guess_finder'
require 'rspec'
require 'rack/test'
require 'capybara/rspec'

ENV['APP_ENV'] = 'test'

# Mixin for testing sinatra

module RSpecMixin
  include Rack::Test::Methods
  def app
    Sinatra::Application
  end
  Capybara.app = Sinatra::Application.new
end

RSpec.configure do |config|
#   # Configure each test to always use a new singleton instance
#   config.before(:each) do
#     TM.instance_variable_set(:@__db_instance, nil)
#   end

  config.include RSpecMixin
  config.include Capybara::DSL
end

# Capybara.configure do |config|
#   config.include RSpecMixin
# end