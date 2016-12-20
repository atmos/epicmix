Rails.application.routes.draw do
  root to: "root#index"
  post "/commands", to: "commands#create"

  get  "/auth/failure",                to: "sessions#destroy"
  get  "/auth/slack/callback",         to: "sessions#create_slack"
  get  "/auth/slack_install/callback", to: "sessions#install_slack"
end
