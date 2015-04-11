class Project < ActiveRecord::Base
  has_many :comments
  has_many :tracks
  has_many :instrument_needs
  belongs_to :user
end
