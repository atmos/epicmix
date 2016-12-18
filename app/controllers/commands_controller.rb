# Handler for incoming slash(/) commands
class CommandsController < ApplicationController
  protect_from_forgery with: :null_session

  def create
    if slack_token_valid?
      render json: { text: ":soon:", response_type: "in_channel" }
    else
      render json: {}, status: 403
    end
  end

  private

  def slack_token
    ENV["SLACK_SLASH_COMMAND_TOKEN"]
  end

  def slack_token_valid?
    ActiveSupport::SecurityUtils.secure_compare(params[:token], slack_token)
  end
end
