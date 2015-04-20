class Track < ActiveRecord::Base
  belongs_to :user
  belongs_to :project

  has_attached_file :audio
  # validates_attachment_content_type :audio, :content_type => ['audio/wav', 'audio/mp3']
  # do_not_validate_attachment_file_type :audio
  validates_attachment_content_type :audio, :content_type => [ 'audio/mpeg', 'audio/x-mpeg', 'audio/mp3', 'audio/x-mp3', 'audio/mpeg3', 'audio/x-mpeg3', 'audio/mpg', 'audio/x-mpg', 'audio/x-mpegaudio' ]


 #Trim WAV file to account for latency

   def self.current_time
    (Time.now.to_f*100000).to_i.to_s
   end

  def self.trim_wav(data, filename)
    binding.pry
    sox = Sox::Cmd.new
    sox.add_input(data.tempfile.to_path)
    sox.set_output("tempaudio/sox-#{filename}.wav")
    sox.set_effects(:trim => 0.05)
    sox.run
  end

  #Converts WAV to MP3
  def self.convert_to_mp3(filename)
    encoder = LAME::Encoder.new

    encoder.configure do |config|
      config.id3.write_automatic = false
      config.id3.v2 = true
      config.quality = 4
      config.bitrate = 192
    end

    wave = WaveFile::Reader.new(File.open("tempaudio/sox-#{filename}.wav"))
    mp3_file = File.new("tempaudio/mp3-#{filename}.mp3", "w+")

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
  end

end
