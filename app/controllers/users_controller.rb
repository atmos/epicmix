# Handler for display information to authenticated users
class UsersController < ApplicationController
  def show
    @user = User.find(session[:user_id])
  end

  def update
    @user = User.find(session[:user_id])
    if !params[:epicmix_email].blank? && !params[:epicmix_password].blank?
      @user.epicmix_email    = params[:epicmix_email]
      @user.epicmix_password = params[:epicmix_password]
      @user.save
    end
    redirect_to profile_path
  end
end
