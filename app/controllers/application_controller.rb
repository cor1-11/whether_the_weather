class ApplicationController < ActionController::Base
  before_action :set_user

  private

  def set_user
    return if @current_user = User.find_by(ip: request.remote_ip)

    @current_user = User.create(ip: request.remote_ip)
  end
end
