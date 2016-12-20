require "rails_helper"

RSpec.describe "EpicMix /privacy", type: [:request] do
  it "informs users on their privacy rights" do
    get "/privacy"
    expect(status).to eql(200)
    doc = Nokogiri::HTML(body)

    expect(body).to include("EpicMix")
  end
end
