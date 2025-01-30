class Admin::ContainerBlocksController < ApplicationController
  def create
    @project = Project.find(params[:project_id])
    @container_block = @project.container_blocks.new(container_block_params)
    @container_block.content_blocks.new(Array.new(@container_block.column_count) do |index|
        {
            position: index + 1,
            class_list: %w[flex justify-center items-center]
        }
      end
    )

    if @container_block.save
      flash.now[:success] = t("container_block_created")
    else
      # TODO
    end
  end

  def update
    @project = Project.find(params[:project_id])
    @container_block = @project.container_blocks.find(params[:id])

    if params[:container_block][:column_count].to_i > @container_block.column_count
      @container_block.content_blocks.new(Array.new(params[:container_block][:column_count].to_i - @container_block.column_count) do |index|
          {
              position: @container_block.content_blocks.ordered.last.position + 1 + index,
              class_list: %w[flex justify-center items-center]
          }
        end
      )
    elsif params[:container_block][:column_count].to_i < @container_block.column_count
      @container_block.content_blocks.ordered.where("position > ?", params[:container_block][:column_count].to_i).destroy_all
    end

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
    params.require(:container_block).permit(:position, :column_count, class_list: [])
  end
end
