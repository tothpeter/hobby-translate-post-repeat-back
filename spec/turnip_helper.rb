# frozen_string_literal: true

Dir[Rails.root.join('spec/acceptance/step_definitions/**/*.rb')].each { |f| require f }

RSpec.configure do |config|
  config.include RSpec::Rails::RequestExampleGroup, type: :feature
end
