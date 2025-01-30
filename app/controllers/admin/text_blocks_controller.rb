class Admin::TextBlocksController < ApplicationController
  def create
    @project = Project.find(params[:project_id])
    @container_block = @project.container_blocks.find(params[:container_block_id])
    @content_block = @container_block.content_blocks.find(params[:content_block_id])
    @content_block.contentable = TextBlock.new(text_block_params)

    if @content_block.save
      flash.now[:success] = t("text_block_created")
    else
      # TODO
    end
  end

  def update
    text_block = TextBlock.find(params[:id])
    if text_block.update(text_block_params)
      @project = Project.find(params[:project_id])
      @container_block = @project.container_blocks.find(params[:container_block_id])
      @content_block = text_block.content_block
      flash.now[:success] = t("content_block_updated")
    else
      # TODO
    end
  end

  def destroy
    TextBlock.find(params[:id]).destroy

    @project = Project.find(params[:project_id])
    @container_block = @project.container_blocks.find(params[:container_block_id])
    @content_block = @container_block.content_blocks.find(params[:content_block_id])

    flash.now[:success] = t("container_block_deleted")
  end

  private

  def content_block_params
    params.require(:content_block).permit(:position, class_list: [])
  end

  def text_block_params
    params.require(:text_block).permit(:text)
  end
end
