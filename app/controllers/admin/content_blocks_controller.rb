class Admin::ContentBlocksController < ApplicationController
  def destroy
    @content_block = ContentBlock.find(params[:id])
    @content_block.destroy
    flash.now[:success] = t("container_block_deleted")
  end
end
