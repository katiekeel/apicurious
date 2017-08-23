class Authorized::ProfileController < Authorized::AuthController

  def show
    @user = current_user
    @starred_repos = User.find_starred_repos(current_user.screen_name)
    @followers = User.find_followers(current_user.screen_name)
    @following = User.find_following(current_user.screen_name)
  end

end
