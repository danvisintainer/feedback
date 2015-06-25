class AddSoundCloudIdToTracks < ActiveRecord::Migration
  def change
    add_column :tracks, :soundcloud_id, :string
    add_column :tracks, :soundcloud_url, :string
  end
end
