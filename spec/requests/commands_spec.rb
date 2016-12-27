require "rails_helper"

RSpec.describe "POST /commands", type: :request do
  def default_params(options = {})
    command_params_for("").merge(
      token: "secret-slack-token",
      user_id: "U1RM9BNL8",
      user_name: "fakeatmos"
    ).merge(options)
  end

  it "403s on a bad token POST to /commands" do
    post "/commands", params: default_params(token: "bad-slack-token")
    expect(status).to eql(403)
  end

  it "201s on a good token POST to /commands" do
    post "/commands", params: default_params(text: "help")
    expect(status).to eql(201)
  end

  it "prompts the user to sign in to the EpicMix when there are no creds" do
    stub_authenticated_user_for_commands

    post "/commands", params: default_params(text: "help")
    expect(status).to eql(201)
    response_body = JSON.parse(body)
    expect(response_body["text"]).to eql(
      "<https://epicmix.atmos.org/profile|Configure EpicMix Account>"
    )
  end

  it "prompts the user to sign in to the slack app when they are unknown" do
    post "/commands", params: default_params(text: "help")
    expect(status).to eql(201)
    response_body = JSON.parse(body)
    expect(response_body["text"]).to eql(
      "<https://epicmix.atmos.org/auth/slack|Login to EpicMix>"
    )
  end
end
