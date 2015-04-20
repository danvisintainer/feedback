class TracksController < ApplicationController
  def create


    filename = Track.current_time
    
    Track.trim_wav(params['data'], filename)
    mp3_file = Track.convert_to_mp3(filename)

    #Use paperclip to upload to AWS
    @track = Track.create(audio: mp3_file)
    puts "done.\n"
    @track.user = User.find(session[:user_id])
    @track.project = Project.find(params[:project_id])
    @track.save

    # Delete temp file on server
    File.delete(mp3_file.path)
    
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
