# frozen_string_literal: true

require 'bundler/setup'
require 'yelp_businesses_search'
require 'webmock/rspec'
require 'pry'

RSpec.configure do |config|
  config.disable_monkey_patching!
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

WebMock.disable_net_connect!
