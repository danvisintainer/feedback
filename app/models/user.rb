class User < ActiveRecord::Base
  has_many :tracks
  has_many :projects
  
  has_attached_file :avatar
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  has_many :comments
  has_secure_password



  def self.instruments
    ["Guitar", "Bass", "Drums", "Keyboards"]
  end

  def musician_type
    case self.primary_instrument
    when "Guitar"
      "Guitarist"
    when "Bass"
      "Bassist"
    when "Drums"
      "Drummer"
    when "Vocals"
      "Vocalist"
    when "Saxophone"
      "Saxophonist"
    when "Keyboards"
      "Keyboardist"
    when "Other"
      "Musician"
    end
  end

end
