require "rails_helper"

RSpec.describe "EpicMix /health", type: [:request] do
  it "notifies on Slack failure" do
    stub_request(:get, "https://slack.com/api/api.test")
      .to_return(body: { ok: false }.to_json, status: 200)

    get "/health"
    expect(status).to eql(500)
    data = JSON.parse(body)
    expect(data["name"]).to eql("epicmix")
    expect(data["slack"]["healthy"]).to be false
  end

  it "verifies Slack" do
    stub_request(:get, "https://slack.com/api/api.test")
      .to_return(body: { ok: true }.to_json, status: 200)

    get "/health"
    expect(status).to eql(200)
    data = JSON.parse(body)
    expect(data["name"]).to eql("epicmix")
    expect(data["slack"]["healthy"]).to be true
  end
end
