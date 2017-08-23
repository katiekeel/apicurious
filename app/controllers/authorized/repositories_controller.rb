class Authorized::RepositoriesController < Authorized::AuthController

  def index
    @repos = User.find_repos(current_user.screen_name)
  end

end
