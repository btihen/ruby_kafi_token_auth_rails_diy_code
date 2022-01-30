class ApplicationController < ActionController::Base
  before_action :users_only

  def current_user(user_id = session[:user_id])
    @current_user ||= User.find_by(id: user_id)
  end

  private
  # send unauthorized users to the root page
  def users_only
    return if current_user.present?

    redirect_back(fallback_location: root_path)
  end
end
