class SessionsController < ApplicationController
  skip_before_action :users_only, only: [:new, :create, :auth]

  def new
    render :new, locals: {user: User.new}
  end
  def create
    user_params = params.require(:user).permit(:email)
    user = User.find_by(email: user_params[:email])
    if user
      global_id = user.to_sgid(expires_in: 15.minutes, for: 'user_access')
      access_url = session_auth_url(token: global_id.to_s)
      UserAuthMailer.send_url(user, access_url).deliver_later
    else
      # do the same logic here to make time the same (prevent user mining)
    end
    redirect_to(root_path, notice: "Access-Link has been sent")
  end

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
