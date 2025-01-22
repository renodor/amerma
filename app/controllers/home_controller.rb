class HomeController < ApplicationController
  def home
    @projects = Project.visible.featured.order(created_at: :desc).limit(3)
  end
end
