class User < ActiveRecord::Base
  has_many :tracks
  has_many :projects
  has_many :comments
  has_secure_password
end
