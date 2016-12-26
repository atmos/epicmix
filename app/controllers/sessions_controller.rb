# Session controller for authenticating users with GitHub/Heroku/Hipchat
class SessionsController < ApplicationController
  include SessionsHelper

  def install_slack
    user = User.from_omniauth(omniauth_info)

    user.save
    session[:user_id] = user.id
    redirect_to profile_path
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
