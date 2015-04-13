class Track < ActiveRecord::Base
  belongs_to :user
  belongs_to :project

  has_attached_file :audio
  # validates_attachment_content_type :audio, :content_type => ['audio/wav', 'audio/mp3']
  # do_not_validate_attachment_file_type :audio
  validates_attachment_content_type :audio, :content_type => [ 'audio/mpeg', 'audio/x-mpeg', 'audio/mp3', 'audio/x-mp3', 'audio/mpeg3', 'audio/x-mpeg3', 'audio/mpg', 'audio/x-mpg', 'audio/x-mpegaudio' ]
end
