class ProjectsController < ApplicationController
  def index
    @project_categories = ProjectCategory.ordered.includes(:projects)
  end

  def show
    @project = Project.find(params[:id])
  end
end
