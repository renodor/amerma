class Admin::PartnersController < Admin::BaseController
  layout "admin"

  def index
    @partners = Partner.all
  end

  def new
    @partner = Partner.new
  end

  def edit
    @partner = Partner.find(params[:id])
  end

  def create
    @partner = Partner.new(partner_params)
    if @partner.save
      flash[:success] = t("partner_created")
      redirect_to edit_admin_partner_path(@partner)
    else
      # TODO
    end
  end

  def update
    @partner = Partner.find(params[:id])
    if @partner.update(partner_params)
      flash.now[:success] = t("partner_updated")
    else
      # TODO
    end
  end

  def destroy
    Partner.find(params[:id]).destroy
    redirect_to admin_partners_path
  end

  private

  def partner_params
    params.require(:partner).permit(:name, :description, :website_url, :logo)
  end
end
