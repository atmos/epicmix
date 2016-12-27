# Handler for display information to authenticated users
class UsersController < ApplicationController
  def show
    @user = current_user
  end

  def update
    @user = current_user
    if !params[:epicmix_email].blank? && !params[:epicmix_password].blank?
      @user.epicmix_email    = params[:epicmix_email]
      @user.epicmix_password = params[:epicmix_password]
      @user.save
    end
    redirect_to profile_path
  end

  def current_user
    @current_user ||= User.find(session[:user_id])
  rescue ActiveRecord::RecordNotFound
    redirect_to "/auth/slack"
  end
end
