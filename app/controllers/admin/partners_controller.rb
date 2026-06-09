class Admin::PartnersController < Admin::BaseController
  layout "admin"

  def index
    @partner_categories = PartnerCategory.ordered.includes(partners: [logo_attachment: :blob])
  end

  def new
    @partner_categories = PartnerCategory.all
    @partner = Partner.new
  end

  def edit
    @partner_categories = PartnerCategory.all
    @partner = Partner.find(params[:id])
  end

  def create
    @partner = Partner.new(partner_params)
    if @partner.save
      flash[:success] = t("partner_created")
      redirect_to edit_admin_partner_path(@partner)
    else
      @partner_categories = PartnerCategory.all
      flash[:error] = t("partner_create_error")
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @partner = Partner.find(params[:id])
    if @partner.update(partner_params)
      flash.now[:success] = t("partner_updated")
    else
      @partner_categories = PartnerCategory.all
      flash[:error] = t("partner_update_error")
      render :edit, status: :unprocessable_entity
    end
  end

  # TODO: DRY
  def update_position
    partner = Partner.find(params[:id])
    @partners = Partner.where(partner_category: partner.partner_category)

    if params[:direction] == "up"
      other_partner = @partners.where("position < ?", partner.position).ordered.last
    else
      other_partner = @partners.where("position > ?", partner.position).ordered.first
    end

    if other_partner
      saved_position = partner.position
      partner.update!(position: other_partner.position)
      other_partner.update!(position: saved_position)
    end
  end

  def destroy
    Partner.find(params[:id]).destroy
    flash[:success] = t("partner_deleted")
    redirect_to admin_partners_path
  end

  private

  def partner_params
    params.require(:partner).permit(:name, :description, :description_en, :website_url, :logo, :partner_category_id)
  end
end
