# Handler for display information to authenticated users
class UsersController < ApplicationController
  def show
    @user = current_user
  end

  def update
    @user = current_user
    @user.update_epicmix_credentials(params[:epicmix_email],
                                     params[:epicmix_password])
    redirect_to profile_path
  end

  def current_user
    @current_user ||= User.find(session[:user_id])
  rescue ActiveRecord::RecordNotFound
    redirect_to "/auth/slack"
  end
end
