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
    expect(response_body["response_type"]).to eql(nil)
  end

  it "prompts the user to sign in to the slack app when they are unknown" do
    post "/commands", params: default_params(text: "help")
    expect(status).to eql(201)
    response_body = JSON.parse(body)
    expect(response_body["text"]).to eql(
      "<https://epicmix.atmos.org/auth/slack|Login to EpicMix>"
    )
    expect(response_body["response_type"]).to eql(nil)
  end

  it "creates a SlashCommand job if the user is valid" do
    user = stub_authenticated_user_for_commands
    user.epicmix_email    = "atmos@atmos.org"
    user.epicmix_password = "mypassword"
    user.save

    user = EpicMix::User.new("atmos@atmos.org", "password")

    authenticate_suffix = "authenticate.ashx?loginID=atmos@atmos.org" \
                          "&password=mypassword"
    stub_request(:post, epic_mix_api_url(authenticate_suffix))
      .with(headers: epic_mix_accept_headers)
      .to_return(epic_mix_authenticated_response)

    userstats_suffix = "userstats.ashx?timetype=season&" \
                       "token=ABCDEFG1234567890"
    stub_request(:post, epic_mix_api_url(userstats_suffix))
      .with(headers: epic_mix_accept_headers.merge(
        Cookie: "ASP.NET_SessionId=abcdefghijklmnopqrstuvwx; website#sc_wede=1; ASP.NET_SessionId=abcdefghijklmnopqrstuvwx"
      )).to_return(epic_mix_userstats_for("atmos"))

    stub_request(:post, "https://hooks.slack.com/commands/T123YG08V/2459573/mfZPdDq").
      with(body: "{\"response_type\":\"in_channel\",\"text\":\"+-----------+---------------+\\n| Name      | Vertical Feet |\\n+-----------+---------------+\\n| fakeatmos | 24057         |\\n+-----------+---------------+\"}",
      ).to_return(:status => 200, :body => "", :headers => {})

    post "/commands", params: default_params(text: "help")
    expect(status).to eql(201)
    response_body = JSON.parse(body)
    expect(response_body["response_type"]).to eql("in_channel")
  end
end
