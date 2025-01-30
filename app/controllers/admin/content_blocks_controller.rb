class Admin::ContentBlocksController < Admin::BaseController
  def update_position
    @project = Project.find(params[:project_id])
    @container_block = @project.container_blocks.find(params[:container_block_id])
    content_block = @container_block.content_blocks.find(params[:id])

    if params[:direction] == "up"
      other_content_block = @container_block.content_blocks.where("position > ?", content_block.position).ordered.first
    else
      other_content_block = @container_block.content_blocks.where("position < ?", content_block.position).ordered.last
    end

    if other_content_block
      saved_position = content_block.position
      content_block.update(position: other_content_block.position)
      other_content_block.update(position: saved_position)
    end
  end
end
