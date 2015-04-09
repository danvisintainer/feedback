class TracksController < ApplicationController
  def create
    binding.pry
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
    Track.destroy(params[:id])
    @id = params[:id]

    respond_to do |f|
      f.js { }
    end
  end

  def show
    @track = Track.find(params[:id])
  end

  def show_all
    @tracks = Track.all
  end

end
