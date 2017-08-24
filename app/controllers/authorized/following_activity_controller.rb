class Authorized::FollowingActivityController < Authorized::AuthController

  def index
    @events = User.find_following_events(current_user.screen_name)
  end

end
