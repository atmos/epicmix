# Session controller for authenticating users with GitHub/Heroku/Hipchat
class SessionsController < ApplicationController
  include SessionsHelper

  def install_slack
    Rails.logger.info omniauth: omniauth_info
    redirect_to "/auth/slack"
  end

  def create_slack
    user = User.from_omniauth(omniauth_info)

    session[:user_id] = user.id
    redirect_to profile_path
  end

  def destroy
    session.clear
    redirect_to root_url, notice: "Signed out!"
  end
end
