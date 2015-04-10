class User < ActiveRecord::Base
  has_many :tracks
  has_many :projects
  
  has_attached_file :avatar
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  has_many :comments
  has_secure_password
end
