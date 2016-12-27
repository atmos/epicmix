Rails.application.routes.draw do
  root to: "pages#home"
  post "/commands", to: "commands#create"

  get "/privacy",                     to: "pages#privacy"
  get "/support",                     to: "pages#support"
  get "/profile",                     to: "users#show"
  put "/profile",                     to: "users#update"
  get "/auth/failure",                to: "sessions#destroy"
  get "/auth/slack/callback",         to: "sessions#create_slack"
  get "/auth/slack_install/callback", to: "sessions#install_slack"
end
