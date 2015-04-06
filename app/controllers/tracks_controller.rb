class TracksController < ApplicationController
  def create
    @track = Track.create(audio: params["data"])
    redirect_to track_path(@track)
  end

  def new

  end

  def show
    @track = Track.find(params[:id])
  end

  def show_all
    @tracks = Track.all
  end

end
