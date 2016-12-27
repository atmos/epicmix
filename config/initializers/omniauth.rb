Rails.application.config.middleware.use OmniAuth::Builder do
  provider :slack, ENV["SLACK_OAUTH_ID"], ENV["SLACK_OAUTH_SECRET"], scope: "identity.basic"
  provider :slack, ENV["SLACK_OAUTH_ID"], ENV["SLACK_OAUTH_SECRET"], scope: "commands,identify,team:read", name: :slack_install
end

OmniAuth.config.logger = Rails.logger
