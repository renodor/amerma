class Admin::PagesController < Admin::BaseController
  layout "admin"

  def index
    @pages = Page.all.order(:created_at)
  end

  def edit
    @page = Page.find(params[:id])
  end

  def update
    @page = Page.find(params[:id])
    if @page.update(page_params)
      flash[:success] = t("page_updated")
      redirect_to edit_admin_page_path(@page)
    else
      flash.now[:error] = t("page_update_error")
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def page_params
    params.require(:page).permit(
      :banner,
      container_blocks_attributes: [
        :id,
        content_blocks_attributes: [
          :id,
          contentable_attributes: [:id, :text, :text_en, :is_raw_html]
        ]
      ]
    )
  end
end
