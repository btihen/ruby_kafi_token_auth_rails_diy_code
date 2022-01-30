class UserAuthMailer < ApplicationMailer
  def send_url(user, auth_url)
    @user = user
    @auth_url = auth_url
    # using dns name
    # @host_name = Rails.application.config.hosts.first
    # using application name
    @host_name = Rails.application.class.module_parent_name
    mail(to: @user.email, subject: "Access-Link for #{@host_name}")
  end
end
