# A team with the slack app install
class Team < ApplicationRecord
  has_many :users

  def self.from_omniauth(omniauth_user_data)
    team = Team.find_or_initialize_by(
      slack_team_id: omniauth_user_data["team"]["id"]
    )
    team.slack_team_name = omniauth_user_data["team"]["name"]
    team.save
    team
  end
end
