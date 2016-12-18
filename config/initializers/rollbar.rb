Rollbar.configure do |config|
  config.access_token = ENV['ROLLBAR_ACCESS_TOKEN']
  if Rails.env.test? || Rails.env.development?
    config.enabled = false
  end
  config.scrub_fields  |= Rollbar::Blanket.fields
  config.scrub_headers |= Rollbar::Blanket.headers
end
