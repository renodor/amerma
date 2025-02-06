class Admin::UsersController < Admin::BaseController
  layout "admin"

  def index
    @users = User.all
  end

  def edit
    redirect_to admin_users_path unless current_user.id == params[:id].to_i
  end

  def update
    redirect_to admin_users_path and return unless current_user.id == params[:id].to_i

    if current_user.update_with_password(user_params)
      # Sign in the user by passing validation in case their password changed
      bypass_sign_in(current_user)
      flash[:success] = t("password_updated")
    else
      flash[:error] = t("update_password_error")
      redirect_to edit_admin_user_path(current_user)
    end
  end

  private

  def user_params
    params.require(:user).permit(:current_password, :password, :password_confirmation)
  end
end
