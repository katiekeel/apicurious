class Authorized::ActivityController < Authorized::AuthController

  def index
    @commits = User.find_events(current_user.screen_name)
  end

end
