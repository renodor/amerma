class Admin::ImageBlocksController < ApplicationController
  def create
    @project = Project.find(params[:project_id])
    @container_block = @project.container_blocks.find(params[:container_block_id])
    @content_block = @container_block.content_blocks.new(content_block_params)
    @content_block.contentable = ImageBlock.new(image_block_params)

    if @content_block.save
      flash.now[:success] = t("text_block_created")
    else
      # TODO
    end
  end

  def update
    image_block = ImageBlock.find(params[:id])
    if image_block.update(image_block_params)
      @project = Project.find(params[:project_id])
      @container_block = @project.container_blocks.find(params[:container_block_id])
      @content_block = image_block.content_block
      flash.now[:success] = t("content_block_updated")
    else
      # TODO
    end
  end

  private

  def content_block_params
    params.require(:content_block).permit(:position, class_list: [])
  end

  def image_block_params
    params.require(:image_block).permit(:title, :subtitle, :image, :caption)
  end
end
