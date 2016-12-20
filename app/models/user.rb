# A user who authenticated from slack
class User < ApplicationRecord
  def self.omniauth_user_data(omniauth_info)
    token = omniauth_info[:credentials][:token]
    response = slack_client.get("/api/users.identity?token=#{token}")

    JSON.parse(response.body)
  end

  def self.from_omniauth(omniauth_info)
    body = omniauth_user_data(omniauth_info)

    user = find_or_initialize_by(
      slack_user_id: body["user"]["id"]
    )
    user.slack_team_id   = body["team"]["id"]
    user.slack_user_name = body["user"]["name"]
    user.save
    user
  end

  def self.slack_client
    Faraday.new(url: "https://slack.com") do |connection|
      connection.headers["Content-Type"] = "application/json"
      connection.adapter Faraday.default_adapter
    end
  end
end
