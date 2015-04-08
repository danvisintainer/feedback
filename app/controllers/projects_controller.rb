class ProjectsController < ApplicationController

  def new
    @project = Project.new
  end

  def create
    @project = Project.create(project_params)
    render 'show'
  end

  def show
    @project = Project.find(:id)
  end

  private
  def project_params
    params.require(:project).permit(:name, :description)
  end

end
