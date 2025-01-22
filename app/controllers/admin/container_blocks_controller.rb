class Admin::ContainerBlocksController < ApplicationController
  def create
    @project = Project.find(params[:project_id])
    @container_block = @project.container_blocks.new(container_block_params)
    if @container_block.save
      flash.now[:success] = t("container_block_created")
    else
      # TODO
    end
  end

  def update
    @project = Project.find(params[:project_id])
    @container_block = @project.container_blocks.find(params[:id])
    if @container_block.update(container_block_params)
      flash.now[:success] = t("container_block_updated")
    else
      # TODO
    end
  end

  def destroy
    @container_block = ContainerBlock.find(params[:id])
    @container_block.destroy
    flash.now[:success] = t("container_block_deleted")
  end

  def update_position
    @project = Project.find(params[:project_id])
    container_block = @project.container_blocks.ordered.find(params[:id])

    if params[:direction] == "up"
      other_container_block = @project.container_blocks.where("position > ?", container_block.position).ordered.first
    else
      other_container_block = @project.container_blocks.where("position < ?", container_block.position).ordered.last
    end

    if other_container_block
      saved_position = container_block.position
      container_block.update(position: other_container_block.position)
      other_container_block.update(position: saved_position)
    end
  end

  private

  def container_block_params
    params.require(:container_block).permit(:position, class_list: [])
  end
end
