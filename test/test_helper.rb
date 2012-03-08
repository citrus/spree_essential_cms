begin
  require "simplecov"
  SimpleCov.start "rails"
rescue LoadError => e
end

# Configure Rails Envinronment
ENV["RAILS_ENV"] = "test"
ENV["RAILS_ROOT"] = File.expand_path("../dummy",  __FILE__)

require "spree_essentials/testing/test_helper"
require "spree_essentials/testing/integration_case"

begin require "turn"; rescue LoadError => e; end

# We'll use ActionConroller's xhr method for faking drag & drops
SpreeEssentials::IntegrationCase.send(:include, ActionController::TestCase::Behavior)

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }
