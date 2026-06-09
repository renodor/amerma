class Admin::ProjectsController < Admin::BaseController
  layout "admin"

  def index
    @project_categories = ProjectCategory.ordered.includes(projects: [cover_photo_attachment: :blob])
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
      @project_categories = ProjectCategory.all
      flash[:error] = t("project_create_error")
      render :new, status: :unprocessable_entity
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
      @project.thumbnail.purge if params[:project][:remove_thumbnail]
      flash[:success] = t("project_updated")
      redirect_to admin_project_path(@project)
    else
      @project_categories = ProjectCategory.all
      flash.now[:error] = t("project_update_error")
      render :edit, status: :unprocessable_entity
    end
  end

  # TODO: DRY
  def update_position
    project = Project.find(params[:id])
    @projects = Project.where(project_category: project.project_category)

    if params[:direction] == "up"
      other_project = @projects.where("position < ?", project.position).ordered.last
    else
      other_project = @projects.where("position > ?", project.position).ordered.first
    end

    if other_project
      saved_position = project.position
      project.update!(position: other_project.position)
      other_project.update!(position: saved_position)
    end
  end

  def destroy
    Project.find(params[:id]).destroy
    flash[:success] = t("project_deleted")
    redirect_to admin_projects_path
  end

  private

  def project_params
    params.require(:project).permit(
      :name, :name_en, :summary, :summary_en, :description, :description_en, :start_date, :end_date, :status, :project_category_id, :visible,
      :featured, :cover_photo, :thumbnail, :owner
    )
  end
end
