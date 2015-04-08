class ProjectsController < ApplicationController

  def new
    @project = Project.new
  end

  def create
    @project = Project.create(project_params)
    redirect_to "/projects/#{@project.id}"
  end

  def show
    @project = Project.find(params[:id])
    @project_id = @project.id
    gon.project_id = @project_id
    @tracks = @project.tracks
  end

  private
  def project_params
    params.require(:project).permit(:name, :description)
  end

end
