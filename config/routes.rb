Rails.application.routes.draw do
  root to: "root#index"
  post "/commands", to: "commands#create"
end
