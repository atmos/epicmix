# A user who authenticated from slack
class User < ApplicationRecord
  belongs_to :team

  include CoalCar::AttributeEncryption

  def self.omniauth_user_data(omniauth_info)
    token = omniauth_info[:credentials][:token]
    response = slack_client.get("/api/users.identity?token=#{token}")

    JSON.parse(response.body)
  end

  def self.from_omniauth(omniauth_info)
    body = omniauth_user_data(omniauth_info)

    team = Team.from_omniauth(body)

    user = team.users.find_or_initialize_by(
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

  def epicmix_user
    return if epicmix_email.blank? || epicmix_password.blank?
    @epicmix_user ||= EpicMix::User.new(epicmix_email, epicmix_password)
  end

  def epicmix_password=(value)
    self[:enc_epicmix_password] = encrypt_value(value)
  end

  def epicmix_password
    decrypt_value(enc_epicmix_password)
  end

  def update_epicmix_credentials(email, password)
    return if email.blank? || password.blank?
    self.epicmix_email    = email
    self.epicmix_password = password
    save
  end
end
