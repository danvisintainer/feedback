class TracksController < ApplicationController
  def create
    @track = Track.create(audio: params["data"])
    @track.user = User.find(session[:user_id])
    @track.project = Project.find(params[:project_id])
    @track.save
    
    respond_to do |f|
      f.js { }
    end
  end

  def new
  end

  def destroy
    @track = Track.find(params[:id])
    @id = params[:id]

    if current_user.id == @track.project.user.id || current_user.id == track.user.id
      @track.destroy
      respond_to do |f|
        f.js { }
      end
    end
  end

  def show
    @track = Track.find(params[:id])
  end

  def show_all
    @tracks = Track.all
  end

end
