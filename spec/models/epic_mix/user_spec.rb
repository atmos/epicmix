require "rails_helper"

RSpec.describe "EpicMix::User" do
  def epic_mix_accept_headers
    {
      "Accept"          => "*/*",
      "Accept-Encoding" => "gzip;q=1.0,deflate;q=0.6,identity;q=0.3",
      "Content-Length"  => "0",
      "Content-Type"    => "application/json",
      "User-Agent"      => "EpicMix 47000 (iPhone; iPhone OS 7.1.2; en_US)"
    }
  end

  def epic_mix_authenticated_response
    {
      status: 200,
      body: epic_mix_fixture_data("authenticate"),
      headers: {
        "Set-Cookie" => "ASP.NET_SessionId=abcdefghijklmnopqrstuvwx"
      }
    }
  end

  def epic_mix_invalid_credentials_response
    {
      status: 400,
      body: "Invalid Credentials",
      headers: {
        "Set-Cookie" => "ASP.NET_SessionId=cdefghijklmnopqrstuvwxyz"
      }
    }
  end

  def epic_mix_api_url(suffix)
    "https://www.epicmix.com/vailresorts/sites/epicmix/api/mobile/#{suffix}"
  end

  it "retrieves the user's token with valid credentials" do
    user = EpicMix::User.new("atmos@atmos.org", "password")

    authenticate_suffix = "authenticate.ashx?loginID=atmos@atmos.org" \
                          "&password=password"
    stub_request(:post, epic_mix_api_url(authenticate_suffix))
      .with(headers: epic_mix_accept_headers)
      .to_return(epic_mix_authenticated_response)

    expect(user.token).to eql("abcdefghijklmnopqrstuvwx")
    expect(user.id).to eql("Gi2696800fs=")
    expect(user.name).to eql("Corey D.")
  end

  it "returns a nil user token with invalid credentials" do
    user = EpicMix::User.new("atmos@atmos.org", "badpassword")

    authenticate_suffix = "authenticate.ashx?loginID=atmos@atmos.org" \
                          "&password=badpassword"
    stub_request(:post, epic_mix_api_url(authenticate_suffix))
      .with(headers: epic_mix_accept_headers)
      .to_return(epic_mix_invalid_credentials_response)

    expect(user.token).to be_nil
    expect(user.id).to be_nil
    expect(user.name).to be_nil
  end
end
