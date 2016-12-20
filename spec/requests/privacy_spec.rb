require "rails_helper"

RSpec.describe "EpicMix /privacy", type: [:request] do
  it "informs users on their privacy rights" do
    get "/privacy"
    expect(status).to eql(200)
    expect do
      Nokogiri::HTML(body)
    end.to_not raise_error

    expect(body).to include("EpicMix")
  end
end
