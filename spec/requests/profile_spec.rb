require "rails_helper"

RSpec.describe "A user's profile page Authentication", type: :request do
  def login_as_fakeatmos
    stub_authenticated_user_for_commands

    OmniAuth.config.mock_auth[:slack] = slack_omniauth_hash_for_non_admin
    get "/auth/slack"
    expect(status).to eql(302)
    uri = Addressable::URI.parse(headers["Location"])
    expect(uri.host).to eql("www.example.com")
    expect(uri.path).to eql("/auth/slack/callback")
    follow_redirect!
    expect(status).to eql(302)
    uri = Addressable::URI.parse(headers["Location"])
    expect(uri.host).to eql("www.example.com")
    expect(uri.path).to eql("/profile")
    follow_redirect!
  end

  it "redirects them to login if no user is found" do
    get "/profile"
    expect(status).to eql(302)
    uri = Addressable::URI.parse(headers["Location"])
    expect(uri.host).to eql("www.example.com")
    expect(uri.path).to eql("/auth/slack")
  end

  it "greets them with their slack username" do
    login_as_fakeatmos

    expect(status).to eql(200)
    expect do
      Nokogiri::HTML(body)
    end.to_not raise_error
    expect(body).to include("Hi, fakeatmos")
  end

  it "updates their epicmix password" do
    login_as_fakeatmos

    user = User.find_by(slack_user_name: "fakeatmos")
    expect(user.epicmix_user).to be_nil

    epicmix_params = {
      epicmix_email: "fakeatmos@gmail.com",
      epicmix_password: SecureRandom.hex(32)
    }
    put "/profile", params: epicmix_params
    expect(status).to eql(302)
    uri = Addressable::URI.parse(headers["Location"])
    expect(uri.host).to eql("www.example.com")
    expect(uri.path).to eql("/profile")
    follow_redirect!

    user = User.find_by(slack_user_name: "fakeatmos")
    expect(user.epicmix_user).to_not be_nil
  end
end

