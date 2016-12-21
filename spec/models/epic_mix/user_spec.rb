require "rails_helper"

RSpec.describe "EpicMix::User" do
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
