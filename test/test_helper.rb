# Configure Rails Envinronment
ENV["RAILS_ENV"] = "test"

require File.expand_path("../dummy/config/environment.rb",  __FILE__)
require 'rails/test_help'
require 'shoulda'
require 'factory_girl'
require 'sqlite3'
require 'faker'


ActionMailer::Base.delivery_method    = :test
ActionMailer::Base.perform_deliveries = true
ActionMailer::Base.default_url_options[:host] = "example.com"

Rails.backtrace_cleaner.remove_silencers!

# Configure capybara for integration testing
require "capybara/rails"
require "selenium/webdriver"

Capybara.default_driver = :selenium
#Capybara.default_selector = :css

# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

include HelperMethods

if 40 <= Spree.version.split(".")[1].to_i
  class ActionController::TestCase
    include Devise::TestHelpers
  end
end


FactoryGirl.define do

  factory :page do
    title            "Just a page"
    meta_title       { nav_title }
    meta_description { "Nothing too cool here except the title: #{title}." } 
    meta_keywords    { "just, something, in, a, list, #{title.downcase}" }
  end

end