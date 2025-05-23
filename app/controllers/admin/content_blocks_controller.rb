class Admin::ContentBlocksController < Admin::BaseController
  def update_position
    @project = Project.find(params[:project_id])
    @container_block = @project.container_blocks.find(params[:container_block_id])
    content_block = @container_block.content_blocks.find(params[:id])

    if params[:direction] == "up"
      other_content_block = @container_block.content_blocks.where("position > ?", content_block.position).first
    else
      other_content_block = @container_block.content_blocks.where("position < ?", content_block.position).last
    end

    if other_content_block
      saved_position = content_block.position
      content_block.update(position: other_content_block.position)
      other_content_block.update(position: saved_position)
    end

    flash.now[:success] = t("#{content_block.text_block? ? 'text' : 'image'}_block_position_updated")
  end
end
