class Authorized::ProfileController < Authorized::AuthController

  def show
    @user = current_user
  end

end
