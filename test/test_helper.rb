begin
  require "simplecov"
  SimpleCov.start do
    add_filter "test/"
  end
rescue LoadError => e
end

# Configure Rails Envinronment
ENV["RAILS_ENV"] = "test"
ENV["RAILS_ROOT"] = File.expand_path("../dummy",  __FILE__)

require "spree_essentials/testing/test_helper"
require "spree_essentials/testing/integration_case"

begin require "turn"; rescue LoadError => e; end

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }
