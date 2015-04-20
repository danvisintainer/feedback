class ProjectsController < ApplicationController
  before_action :require_login, only: [:create, :destroy]

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

    @open_projects = @projects.select {|p| !p.completed}
    @completed_projects = @projects.select {|p| p.completed}

    if current_user
      @personalized_projects =  Project.joins(:instrument_need).where("#{current_user.primary_instrument} = '1'")
    end 
  end

  def show
    @project = Project.find(params[:id])
    @project_id = @project.id
    gon.project_id = @project_id
    @tracks = @project.tracks
    gon.project_completed = @project.completed

    # Create a new instance of InstrumentNeed for the project if it does not already have one.
    @instrument_need = @project.instrument_need || (@project.instrument_need = InstrumentNeed.create)
  end

  def update
    @project = Project.find(params[:id])
    if project_owner?
      @project.update(completed: params[:completed])
      #reset InstrumetntNeed on completion of project
      if params[:completed] == "true"
        @project.instrument_need.destroy
        @project.instrument_need = InstrumentNeed.new
      end

      puts "----------------------------------------------"
      puts "completed status is now: #{@project.completed}"
      puts "----------------------------------------------"

      # gon.project_completed = @project.completed
      respond_to do |f|
        f.js { }
      end
    end
  end

  def destroy
    @project = Project.find(params[:id])
    if project_owner?
      @project.destroy
      redirect_to "/users/#{current_user.id}"
    else
      flash[:error] = "Only the project's owner can delete it."
      redirect_to projects_path(@project)
    end
  end

  private
  def project_params
    params.require(:project).permit(:name, :description)
  end

  def require_login
    unless current_user
    flash[:error] = "You must be logged in to create a new project."
      redirect_to 'root'
    end
  end

end
