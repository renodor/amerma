class HomeController < ApplicationController
  def home
    @project_categories = ProjectCategory.ordered
    @projects = Project.visible.featured.order(created_at: :desc).limit(3)
  end
end
