class Admin::PartnerCategoriesController < Admin::BaseController
  layout "admin"

  def index
    @partner_categories = PartnerCategory.ordered
  end

  def edit
    @partner_category = PartnerCategory.find(params[:id])
    @icons = Rails.root.glob("app/assets/images/icons/pixel-pack/*.svg").map { File.basename(it, ".svg") }.sort
  end

  def update
    @partner_category = PartnerCategory.find(params[:id])
    if @partner_category.update(partner_category_params)
      flash.now[:success] = t("partner_category_updated")
    else
      flash[:error] = t("partner_category_update_error")
      redirect_to edit_admin_partner_category_path(@partner_category)
    end
  end

  def update_position
    @partner_categories = PartnerCategory.all
    partner_category = @partner_categories.find(params[:id])

    if params[:direction] == "up"
      other_partner_category = @partner_categories.where("position < ?", partner_category.position).ordered.last
    else
      other_partner_category = @partner_categories.where("position > ?", partner_category.position).ordered.first
    end

    if other_partner_category
      saved_position = partner_category.position
      partner_category.update(position: other_partner_category.position)
      other_partner_category.update(position: saved_position)
    end
  end

  private

  def partner_category_params
    params.require(:partner_category).permit(:name, :name_en, :description, :description_en, :icon)
  end
end
