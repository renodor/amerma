class Admin::ProjectsController < Admin::BaseController
  layout "admin"

  def index
    @projects = Project.all.order(created_at: :desc)
  end

  def show
    @project_categories = ProjectCategory.all
    @project = Project.find(params[:id])
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
    else
      # TODO
    end
  end

  def destroy
    Project.find(params[:id]).destroy
    redirect_to admin_projects_path
  end

  private

  def project_params
    params.require(:project).permit(:name, :description, :start_date, :end_date, :status, :project_category_id, :visible, :featured, :cover_photo, :owner)
  end
end
