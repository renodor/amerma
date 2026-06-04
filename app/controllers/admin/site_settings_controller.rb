class Admin::SiteSettingsController < Admin::BaseController
  layout "admin"

  def edit; end

  def update
    if @site_setting.update(site_setting_params)
      flash.now[:success] = t("settings_updated")
    else
      flash[:error] = t("settings_update_error")
      redirect_to edit_admin_site_setting_path(@site_setting)
    end
  end

  private

  def site_setting_params
    params.require(:site_setting).permit(:logo)
  end
end
