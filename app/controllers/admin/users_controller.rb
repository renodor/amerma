class Admin::UsersController < Admin::BaseController
  layout "admin"

  def index
    @users = User.all
  end
end
