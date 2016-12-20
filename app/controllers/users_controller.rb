# Handler for display information to authenticated users
class UsersController < ApplicationController
  def show
    @user = User.find(session[:user_id])
  end
end
