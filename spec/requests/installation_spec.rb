require "rails_helper"

RSpec.describe "Slack Application Installation", type: :request do
  it "creates a user when installed" do
    OmniAuth.config.mock_auth[:slack_install] = slack_omniauth_hash_for_install
    expect do
      get "/auth/slack_install"
      expect(status).to eql(302)
      uri = Addressable::URI.parse(headers["Location"])
      expect(uri.host).to eql("www.example.com")
      expect(uri.path).to eql("/auth/slack_install/callback")
      follow_redirect!
      expect(status).to eql(302)
      uri = Addressable::URI.parse(headers["Location"])
      expect(uri.host).to eql("www.example.com")
      expect(uri.path).to eql("/auth/slack")
    end.to change { Team.count }.by(1)

    team = Team.first
    expect(team.slack_team_name).to eql("Atmos Dot Org")
  end
end
