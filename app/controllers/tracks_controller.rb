class TracksController < ApplicationController
  def create
    @track = Track.create(audio: params["data"])
    binding.pry
    respond_to do |f|
      f.js { }
    end
    # redirect_to track_path(@track)
  end

  def new

  end

  def test
    
  end

  def show
    @track = Track.find(params[:id])
    # render layout: false
  end

  def show_all
    @tracks = Track.all
  end

end
