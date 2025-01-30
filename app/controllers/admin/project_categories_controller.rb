class Admin::ProjectCategoriesController < ApplicationController
  layout "admin"

  def index
    @project_categories = ProjectCategory.ordered
  end

  def edit
    @project_category = ProjectCategory.find(params[:id])
  end

  def update
    @project_category = ProjectCategory.find(params[:id])
    if @project_category.update(project_category_params)
      flash.now[:success] = t("project_category_updated")
    else
      # TODO
    end
  end

  def update_position
    @project_categories = ProjectCategory.all
    project_category = @project_categories.find(params[:id])

    if params[:direction] == "up"
      other_project_category = @project_categories.where("position > ?", project_category.position).ordered.first
    else
      other_project_category = @project_categories.where("position < ?", project_category.position).ordered.last
    end

    if other_project_category
      saved_position = project_category.position
      project_category.update(position: other_project_category.position)
      other_project_category.update(position: saved_position)
    end
  end

  private

  def project_category_params
    params.require(:project_category).permit(:name, :description)
  end
end
