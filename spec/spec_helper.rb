require 'rspec'
require 'capybara'
require 'capybara/rspec'
require 'selenium/webdriver'
require 'httparty'

Capybara.register_driver :chrome do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end

Capybara.register_driver :headless_chrome do |app|
  capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
    chromeOptions: { args: %w(headless disable-gpu) }
  )

  Capybara::Selenium::Driver.new app,
    browser: :chrome,
    desired_capabilities: capabilities
end

Capybara.javascript_driver = :headless_chrome

risky_business_pid = nil

def wait_for_risky_business
  25.times do
    resp = HTTParty.get('http://localhost:9292/health')
    return if resp.status == 200
  end
  puts 'Risky Business simulator failed to start'
  exit
end

RSpec.configure do |config|

  config.before(:suite) do
    command = 'cd spec && bundle exec rackup simulators/config_risky_business.ru'
    puts 'Starting Risky Business simulater'
    risky_business_pid = Process.spawn(command)
    Process.detach risky_business_pid
    wait_for_risky_business
  end

  config.after(:suite) do
    puts 'Shutting down Risky Business simulator'
    Process.exit(risky_business_pid)
  end
end
