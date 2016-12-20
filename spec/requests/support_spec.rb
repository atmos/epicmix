require "rails_helper"

RSpec.describe "EpicMix /support", type: [:request] do
  it "redirects to an email link" do
    get "/support"
    expect(status).to eql(302)
    doc = Nokogiri::HTML(body)

    expect(body).to include("atmos+epicmix+support@atmos.org")
  end
end
