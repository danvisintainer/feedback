class TracksController < ApplicationController
  def create
    encoder = LAME::Encoder.new

    encoder.configure do |config|
      config.id3.write_automatic = false
      config.id3.v2 = true
      config.quality = 4
      config.bitrate = 192
    end
    
    binding.pry
    print "Converting to MP3..."

    mp3_path = Tempfile.new("mp3output.mp3")
    File.open(mp3_path, "wb") do |file|

      id3v2_size = 0
      encoder.id3v2 do |tag|
        file.write tag
        id3v2_size = tag.size
      end

      params["data"].each_buffer(encoder.framesize) do |read_buffer|
        left  = read_buffer.samples.map { |s| s[0] }
        right = read_buffer.samples.map { |s| s[1] }

        encoder.encode_short(left, right) do |mp3|
          file.write mp3
        end
      end
      encoder.flush do |flush_frame|
        file.write(flush_frame)
      end

      encoder.id3v1 do |tag|
        file.write tag
      end

      encoder.vbr_frame do |vbr_frame|
        file.seek(id3v2_size)
        file.write(vbr_frame)
      end

    end
    print "Done."

    print "Setting track to AWS..."
    @track = Track.create(audio: mp3_path)
    print "Done.\n"
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
