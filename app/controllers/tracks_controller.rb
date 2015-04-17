class TracksController < ApplicationController
  def create
    encoder = LAME::Encoder.new

    encoder.configure do |config|
      config.id3.write_automatic = false
      config.id3.v2 = true
      config.quality = 4
      config.bitrate = 192
    end

    puts "Trimming WAV..."

    current_time = (Time.now.to_f*100000).to_i.to_s

    sox = Sox::Cmd.new
    sox.add_input(params['data'].tempfile.to_path)
    sox.set_output("tempaudio/sox-#{current_time}.wav")
    sox.set_effects(:trim => 0.05)

    sox.run

    puts "Done.\n"
    
    puts "Converting to MP3..."
    wave = WaveFile::Reader.new(File.open("tempaudio/sox-#{current_time}.wav"))
    mp3_file = File.new("tempaudio/mp3-#{current_time}.mp3", "w+")

    File.open(mp3_file, "wb") do |file|

      id3v2_size = 0
      encoder.id3v2 do |tag|
        file.write tag
        id3v2_size = tag.size
      end

      wave.each_buffer(encoder.framesize) do |read_buffer|
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

    puts "done."

    puts "Setting track to AWS..."

    @track = Track.create(audio: mp3_file)
    puts "done.\n"
    @track.user = User.find(session[:user_id])
    @track.project = Project.find(params[:project_id])
    @track.save

    puts "Deleting file..."
    File.delete(mp3_file.path)
    puts "done."
    
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
