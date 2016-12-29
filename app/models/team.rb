# A team with the slack app install
class Team < ApplicationRecord
  has_many :users

  def self.from_omniauth_install(omniauth_install_data)
    team = Team.find_or_initialize_by(
      slack_team_id: omniauth_install_data["team_id"]
    )
    team.slack_team_name = omniauth_install_data["team"]
    team.save
    team
  end

  def self.from_omniauth(omniauth_user_data)
    team = Team.find_or_initialize_by(
      slack_team_id: omniauth_user_data["team"]["id"]
    )
    team.slack_team_name = omniauth_user_data["team"]["name"]
    team.save
    team
  end

  def leaderboard_users
    @leaderboard_users ||= users.sort_by(&:vertical_feet).reverse
  end

  def leaderboard
    @leaderboard ||= Leaderboard.new(leaderboard_users)
  end
end
