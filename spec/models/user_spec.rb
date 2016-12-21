require "rails_helper"

RSpec.describe User, type: :model do
  before do
    token = "xoxp-9101111159-5657146422-59735495733-3186a13efg"
    stub_json_request(:get,
                      "https://slack.com/api/users.identity?token=#{token}",
                      fixture_data("slack.com/identity.basic"))
  end

  let(:user) { User.from_omniauth(slack_omniauth_hash_for_non_admin) }

  it "encrypt's users epicmix passwords" do
    user.epicmix_email    = "atmos@atmos.org"
    user.epicmix_password = "passwerd"
    user.save

    user.reload

    expect(user.epicmix_email).to eql("atmos@atmos.org")
    expect(user.epicmix_password).to eql("passwerd")
    expect(user.epicmix_user).to_not be_nil
  end
end
