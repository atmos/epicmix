require "rails_helper"

RSpec.describe User, type: :model do
  let(:user) { stub_authenticated_user_for_commands }

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
