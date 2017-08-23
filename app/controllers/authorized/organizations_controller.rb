class Authorized::OrganizationsController < Authorized::AuthController

  def index
    @organizations = User.find_organizations(current_user.screen_name)
  end

end
