class Admin::ProjectsController < Admin::BaseController
  layout "admin"

  def index
    @projects = Project.all.order(created_at: :desc)
  end

  def new
    @project_categories = ProjectCategory.all
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      flash[:success] = t("project_created")
      redirect_to admin_project_path(@project)
    else
      flash[:error] = t("project_create_error")
      redirect_to new_admin_project_path(@project)
    end
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
      flash[:error] = t("project_update_error")
      redirect_to admin_project_path(@project)
    end
  end

  def destroy
    Project.find(params[:id]).destroy
    flash[:success] = t("project_deleted")
    redirect_to admin_projects_path
  end

  private

  def project_params
    params.require(:project).permit(:name, :name_en, :description, :description_en, :start_date, :end_date, :status, :project_category_id, :visible, :featured, :cover_photo, :owner)
  end
end
