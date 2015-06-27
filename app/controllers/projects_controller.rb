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
      # @open_projects.delete_if {|p| @personalized_projects.include?(p) }
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

  def soundcloud_project_upload
    @project = Project.find(params[:id])
    # create a client object with access token
    client = Soundcloud.new(:access_token => current_user.soundcloud_token)

    sox_command = "sox -m "
    @project.tracks.collect do |track|
      #remove query string from url
      question_mark_index = track.audio.url.index('?')
      track_url = "http:" + track.audio.url.slice(0..(question_mark_index-1))
      tempfile = open(track_url)
      sox_command = sox_command + '-t mp3 ' + tempfile.path + " "
    end

    sox_command += "merged_project.mp3"

    #use sox to merge tracks
    system sox_command

    # upload an audio file
    @upload = client.post('/tracks', :track => {
      :title => "#{@project.name} created using Feedback",
      :asset_data => open('merged_project.mp3')
    })

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
