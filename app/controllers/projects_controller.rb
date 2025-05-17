class ProjectsController < ApplicationController
  def index
    @project_categories = ProjectCategory.ordered.includes(projects: [cover_photo_attachment: :blob])
  end

  def show
    @project = Project.find(params[:id])
    @container_blocks = @project.container_blocks.includes(
      content_blocks: [contentable: [:rich_text_text, :rich_text_text_en, image_attachment: :blob]]
    )

    redirect_to projects_path unless @project.visible?
  end
end
