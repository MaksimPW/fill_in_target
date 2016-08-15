require 'capybara/poltergeist'
require "rack_session_access/capybara"

Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, js_errors: false)
end

Capybara.default_driver = :poltergeist
Capybara.default_max_wait_time = 10