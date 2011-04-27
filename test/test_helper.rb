# Configure Rails Envinronment
ENV["RAILS_ENV"] = "test"
  
require 'rubygems'
require 'spork'

Spork.prefork do
  require File.expand_path("../dummy/config/environment.rb",  __FILE__)
  require 'spree_essentials/test_helper'
end

Spork.each_run do
  Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }
  include HelperMethods
end