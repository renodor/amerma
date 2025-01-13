class Admin::ProjectsController < ApplicationController
  layout "admin"

  def index
    @projects = Project.all
  end

  def edit
    @project = Project.find(params[:id])
  end

  def update
    binding.pry
  end
end
