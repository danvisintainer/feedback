class Track < ActiveRecord::Base
  belongs_to :user
  belongs_to :project

  has_attached_file :audio
  validates_attachment_content_type :audio, :content_type => ['audio/wav', 'audio/mp3']
end
