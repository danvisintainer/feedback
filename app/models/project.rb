class Project < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  has_many :tracks, dependent: :destroy
  has_one :instrument_need
  belongs_to :user
end
