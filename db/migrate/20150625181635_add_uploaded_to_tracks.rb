class AddUploadedToTracks < ActiveRecord::Migration
  def change
    add_column :tracks, :uploaded, :boolean, :default => false
  end
end
