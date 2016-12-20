require "rails_helper"

RSpec.describe "EpicMix /support", type: [:request] do
  it "redirects to an email link" do
    get "/support"
    expect(status).to eql(302)
    expect do
      Nokogiri::HTML(body)
    end.to_not raise_error

    expect(body).to include("atmos+epicmix+support@atmos.org")
  end
end
