class Project < ActiveRecord::Base
  has_many :comments
  has_many :tracks
  belongs_to :user
end
