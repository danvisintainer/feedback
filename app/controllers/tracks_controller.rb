class TracksController < ApplicationController
  def create
    if params.has_key?("tempo")
      # If the user asked for a click-track, load one of the clicktrack samples.
      @track = Track.create(audio: File.open("samples/#{params["tempo"]}.mp3"))
    else
      # Otherwise, take in the recorded track.
      filename = Track.current_time
      
      # Trim WAV file & convert to MP3 
      Track.trim_wav(params['data'], filename)
      mp3_file = Track.convert_to_mp3(filename)

      # Use paperclip to upload to AWS
      @track = Track.create(audio: mp3_file)
    end
      
    @track.user = User.find(session[:user_id])
    @track.project = Project.find(params[:project_id])
    @track.save

    # Delete temp file on server
    File.delete(mp3_file.path) if !params.has_key?("tempo")
    
    respond_to do |f|
      f.js { }
    end
  end

  def new
  end

  def destroy
    @track = Track.find(params[:id])
    @id = params[:id]
    if current_user.id == @track.project.user.id || current_user.id == @track.user.id
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
