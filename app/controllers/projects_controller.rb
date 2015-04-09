class ProjectsController < ApplicationController

  def new
    @project = Project.new
  end

  def create
    @project = Project.create(project_params)
    @project.user = User.find(session[:user_id])
    @project.save
    redirect_to "/projects/#{@project.id}"
  end

  def index
    @projects = Project.all
  end

  def show
    @project = Project.find(params[:id])
    @project_id = @project.id
    gon.project_id = @project_id
    @tracks = @project.tracks
  end

  def update
    @project = Project.find(params[:id])
    if @project.user.id == current_user.id
      @project.update(completed: params[:completed])
      respond_to do |f|
        f.js { }
      end
    end
  end

  def destroy
    Project.destroy(params[:id])
    redirect_to "/users/#{current_user.id}"
  end

  private
  def project_params
    params.require(:project).permit(:name, :description)
  end

end
