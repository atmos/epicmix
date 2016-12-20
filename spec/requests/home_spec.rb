require "rails_helper"

RSpec.describe "EpicMix /", type: [:request] do
  it "explains why it exists" do
    get "/"
    expect(status).to eql(200)
    expect do
      Nokogiri::HTML(body)
    end.to_not raise_error

    expect(body).to include("Welcome")
  end
end
