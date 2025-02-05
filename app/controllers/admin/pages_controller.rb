class Admin::PagesController < Admin::BaseController
  layout "admin"

  def index
    @pages = Page.all
  end

  def edit
    @page = Page.find(params[:id])
  end

  def update_text_block
    @page = Page.find(params[:page_id])
    text_block = TextBlock.find(params[:id])
    if text_block.update(text_block_params)
      flash.now[:success] = t("text_block_updated")
    else
      flash[:error] = t("text_block_update_error")
      redirect_to edit_admin_page_path(@page)
    end
  end

  private

  def text_block_params
    params.require(:text_block).permit(:text, :text_en)
  end
end
