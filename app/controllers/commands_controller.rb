# Handler for incoming slash(/) commands
class CommandsController < ApplicationController
  protect_from_forgery with: :null_session

  def create
    if slack_token_valid?
      if epicmix_user && epicmix_user.token
        render json: {
          text: epicmix_user.vertical_feet,
          response_type: "in_channel"
        }, status: 201
      elsif current_user
        render json: {
          text: "<https://epicmix.atmos.org/profile|Configure EpicMix Account>"
        }, status: 201
      else
        render json: {
          text: "<https://epicmix.atmos.org/auth/slack|Login to EpicMix>"
        }, status: 201
      end
    else
      render json: {}, status: 403
    end
  end

  private

  def epicmix_user
    current_user && current_user.epicmix_user
  end

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
