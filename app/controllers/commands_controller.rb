# Handler for incoming slash(/) commands
class CommandsController < ApplicationController
  protect_from_forgery with: :null_session

  def create
    if slack_token_valid?
      if current_user && current_user.epicmix_user.token
        render json: {
          text: current_user.epicmix_user.current_season.vertical_feet,
          response_type: "in_channel"
        }, status: 201
      else
        render json: { text: ":soon:", response_type: "in_channel" }, status: 201
      end
    else
      render json: {}, status: 403
    end
  end

  private

  def current_user
    @current_user ||= User.find_by(slack_user_id: params[:user_id],
                                   slack_team_id: params[:team_id])
  end

  def slack_token
    ENV["SLACK_SLASH_COMMAND_TOKEN"]
  end

  def slack_token_valid?
    ActiveSupport::SecurityUtils.secure_compare(params[:token], slack_token)
  end
end
