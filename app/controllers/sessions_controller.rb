class SessionsController < ApplicationController
  skip_before_action :users_only, only: [:auth]

  def auth
    user_token = params[:token].to_s # to_s prevents nil error
    user = GlobalID::Locator.locate_signed(user_token, for: 'user_access')
    if user
      session[:user_id] = user.id # create the session as designed
      redirect_to user_path(user), notice: "Welcome back #{user.name}"
    else
      redirect_to(root_path, alert: "login link needed")
    end
  end
  # logout
  def destroy
    session.clear
    redirect_to(root_path, notice: "logout successful")
  end
end
