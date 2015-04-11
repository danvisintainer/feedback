class Project < ActiveRecord::Base
  has_many :comments
  has_many :tracks
  has_one :instrument_need
  belongs_to :user
end
