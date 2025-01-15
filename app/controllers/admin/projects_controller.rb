class Admin::ProjectsController < ApplicationController
  layout "admin"

  def index
    @projects = Project.all
  end

  def edit
    @project_categories = ProjectCategory.all
    @project = Project.find(params[:id])
  end

  def update
    @project = Project.find(params[:id])
    if @project.update(project_params)
      @project.cover_photo.purge if params[:project][:remove_cover_photo]
      flash.now[:success] = t("project_updated")
      render turbo_stream: turbo_stream.update("flash", partial: "shared/flash")
    else
    end
  end

  private

  def project_params
    params.require(:project).permit(
      :name, :description, :start_date, :end_date, :status, :project_category_id, :visible, :cover_photo,
      container_blocks_attributes: [:id, class_list: []]
    )
  end
end
