class SlashCommandJob < ApplicationJob
  queue_as :default

  attr_reader :response_url

  def perform(*args)
    params = args.first
    user = User.find_by(slack_user_id: params[:user_id],
                        slack_team_id: params[:team_id])

    @response_url = params[:response_url]

    leaderboard = user.team.leaderboard
    message = {
      response_type: "in_channel",
      text: leaderboard.to_ascii_table
    }
    postback_message(message)
  end

  private
  def postback_message(message)
    response = client.post do |request|
      request.url callback_uri.path
      request.body = message.to_json
      request.headers["Content-Type"] = "application/json"
    end

    Rails.logger.info response.body
  rescue StandardError => e
    Rails.logger.info "Unable to post back to slack: '#{e.inspect}'"
  end

  def callback_uri
    @callback_uri ||= Addressable::URI.parse(response_url)
  end

  def client
    @client ||= Faraday.new(url: "https://hooks.slack.com")
  end
end
