class Authorized::AuthController < ApplicationController
  before_action :require_auth

  def require_auth
    render file: "/public/404" unless current_user
  end
end
